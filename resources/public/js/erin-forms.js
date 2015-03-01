function closeForm(elem) {

    $('#'+elem).hide();
}
function renderTemplate(name, data, target) {
    dust.render(name, data, function (err, out) {
        if ( err )
            console.log("ERROR:" + err);
        $(target).html(out);
    });
}

function setupForm( name, func, update) {
    var formName = '#' + name + '-form';
    $(formName).submit(function (event) {
        func(event, name, '#' + name + '-form');
    });
    console.log(formName + ', update=' + update);
    if ( update ) {

        $(formName + ' #submit').html("Update");
    }
}


function compileTemplate(name) {

    return $.ajax("templates/" + name + ".tl", {
        success: function (data) {
            var compiled = dust.compile(data, name);
            dust.loadSource(compiled);
            console.log("compiled templates named:" + name);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
        }
    });

}

function toJSON(o) {
    var j = {};
    for ( var i in o ) {
        if ( o[i].name != undefined && o[i].value != undefined) {
            if ( o[i].value !== "") {
                j[o[i].name] = o[i].value;
            }
        }
    }
    return JSON.stringify(j);
}
function setStatus(msg) {
    $( "#status-message" ).html(msg).fadeOut( 2000, "linear", function() {
        $( "#status-message" ).html("").show();
    });
}

function getVersionedRoot() {
    return "/v1/erin/";
}

function postForm(event, entity, formName) {
    event.preventDefault();
    var dataToBeSent = toJSON($(formName).serializeArray());
    return $.ajax({
        type: "POST",
        url: getVersionedRoot() + entity,
        headers: {
            "Content-Type" : "application/json"
        },
        data: dataToBeSent,
        success: function(data) {
            setStatus("Added");
            var id = data[0].id;

            var callMenu = false;
            if ( data[0].people_id != undefined) {
                id = data[0].people_id;
                callMenu = true;
            }
            if ( callMenu) {
                var tab = '#' + entity + '-tab';
                if ($(tab).trigger != undefined) {
                    $(tab).trigger('click');
                }
            } else {
                window.location.replace("/" + ROOT_ENTITY + ".html?id=" + id);
            }
        },

        fail: function(err) {
            alert("fail:" + err.status);
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            $('#exception').html(XMLHttpRequest.responseText);
        }

    });
}
function putForm(event, entity, formName) {

    event.preventDefault();
    var serialized = $(formName).serializeArray();

    var id = serialized.filter(function (elem) { return elem.name == "id" })[0].value;

    var dataToBeSent = toJSON(serialized);
    return $.ajax({
        type: "PUT",
        url: getVersionedRoot() + entity + '/'  + id,
        headers: {
            "Content-Type" : "application/json"
        },
        success: function(data) {
            setStatus("Updated");
            var tab = '#' + entity + '-tab';
            if ($(tab).trigger != undefined) {
                $(tab).trigger('click');
            } else {
                window.location.reload();
            }
        },

        data: dataToBeSent,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            $('#exception').html(XMLHttpRequest.responseText);
        },
        fail: function(err) {
            alert("fail:" + err.status);
        }

    });
}

function setupTab(name, parent_id_name , parent_id) {

    $('#' + name + '-tab').click(function (e) {

        if ( typeof parent_id != 'undefined' && parent_id !== -1 ) {

            compileTemplate(name);
            $.getJSON(getVersionedRoot() + name + "?" + parent_id_name + "=" + parent_id, function (data) {
                renderTemplate(name, data);
                setupForm(name, putForm, true);

            })
                .fail(function (err) {
                    var jsonData = {};
                    jsonData[parent_id_name] = parent_id;
                    renderTemplate(name, jsonData, postForm, false);
                    setupForm(name, postForm, false);
                })
                .error(function(XMLHttpRequest, textStatus, errorThrown) {
                    if ( XMLHttpRequest.status == 500) {
                        $('#exception').html(XMLHttpRequest.responseText);
                    }
                });

        }
        return false;
    });

}

function setupTabs(parent_id_name, parent_id) {
    $.map(CHILD_ENTITIES, function(child,i) {
        setupTab(child.entity, child.parent_id_name, parent_id);
    });
}

function showSearchBox(name) {
    $('#' + name).val('');
    $('#' + name).show();
    $('#' + name).focus();

}

function generateLookupComponent(entity) {
    var dhtml = "<div class='ui-widget' id='__ENTITY___lookup_wrapper'>" +
        "<label for='__ENTITY___lookup'><a href='javascript:showSearchBox(\"__ENTITY___lookup\");'><img src='icons/toolbar_find.png'></a></label>" +
            "<input class='search-box-hidden' id='__ENTITY___lookup' name=__ENTITY___lookup' value=''></div>";


    var r = dhtml.replace(/__ENTITY__/g,entity);
    $('#main').append(r);


}
function initLookup(entity, col, displayCols, targetElem, alignTo, idCol ) {

    generateLookupComponent(entity);
    var lookup = '#' + entity + '_lookup';
    var wrapper = lookup + '_wrapper';
    if ( typeof idCol == 'undefined' ) {
        idCol = "id";
    }
    $(lookup).autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "/v1/erin/" + entity + "/lookup",
                data: {
                    val: request.term,
                    col: col,
                    id_col: idCol,
                    display_cols: displayCols
                },
                success: function (data) {
                    return response(data);

                }
            });
        },

        select: function (e, ui) {

            if ( targetElem.indexOf('#') === 0 ) {
                $(targetElem).val(ui.item.data);
            }  else {

                window.location.replace(targetElem + ui.item.data);
            }
            $(lookup).hide();
        },
        delay: 500,
        minLength: 3,
        response: function (event, ui) {
            if (!ui.content.length) {
                var noResult = { value: "", label: "No Match" };
                ui.content.push(noResult);
            }

        }

    });

    if (alignTo ) {
        $(wrapper).position({
            my: "left",
            at: "left",
            of: alignTo,
            collision: "flip"
        })
    }
}

function lookupEntityById(entity,id,  dataCallback ) {

    if( ! id ) {
        id = "__XXXX___";
    }
    var entityData = {};
    var error = false;

    var url = getVersionedRoot() + entity + "/" + id;
     return $.ajax({
        url: url,
        type: "GET",
        success: function (data) {
            entityData = data;
        },
         error: function (jqXHR, textStatus, errorThrown) {
            if ( jqXHR.status != 404 ) {
                 error = true;
                $('#exception').html(jqXHR.responseText);
            }
        },
        complete: function () {
             if ( ! error )
                dataCallback( entityData);
         }
    });
}

// load the root entity form
function initErinForms( entity, id, target, callBacks) {

        compileTemplate(entity).then(function () {
            if (id) {
                $.getJSON(getVersionedRoot() + entity + "/" + id, function (data) {
                    renderTemplate(entity, data, target);
                 //   setupTabs(entity + "_id", id);
                    setupForm(entity, putForm, true);
                    callBack();


                })
                    .fail(function (err) {
                        if (err.status == 404) {
                            alert("Cannot locate " + entity + " by id " + id);
                        }
                    })
                    .error(function (XMLHttpRequest, textStatus, errorThrown) {
                        $('#exception').html(XMLHttpRequest.responseText);
                    });


            } else { // render an empty form for adding a new record
                renderTemplate(entity, {}, target);
                setupForm(entity, postForm, false);
               // callBack();

            }
        });
}

function populateDetail(entity, id) {

        $.getJSON(getVersionedRoot() + entity + "/" + id, function (data) {

            renderTemplate(entity, data, '#main');
//            setupTabs(entity + "_id", id);
            setupForm(entity, putForm, true);

        })
            .fail(function (err) {
                if (err.status == 404) {
                    alert("Cannot locate " + entity + " by id " + id);
                }
            })
            .error(function (XMLHttpRequest, textStatus, errorThrown) {
                $('#exception').html(XMLHttpRequest.responseText);
            });

}
function populateSummary(entity, key, value, target) {

    var name = entity + "-summary";
    compileTemplate(name).then( function() {

        $.getJSON(getVersionedRoot() + entity +"?"+ key +"=" +value, function (data) {
            renderTemplate(name, data, target);
        })
        .fail(function (err) {
                if (err.status == 404) {
                   // alert("Cannot locate " + entity + "(s)");
                }

        })
         .error(function (XMLHttpRequest, textStatus, errorThrown) {
                    $('#exception').html(XMLHttpRequest.responseText);
         });
        });
}
function populateRelationships(entity, data, target) {

    var name = entity + "-relationships";
    compileTemplate(name).then( function() {
        renderTemplate(name, data, target);
    });
}

function filterFields(data, map) {
    var filtered = {};
    for ( var k in map) {
        if ( data[k]) {
            filtered[map[k]] = data[k];
        }
    }
    return filtered;
}


function prepopulateForm(entity, parent_entity, value, target, prePopMap) {
    lookupEntityById(parent_entity, value, function( data) {
        renderTemplate(entity, filterFields(data, prePopMap), target);
    });
}




