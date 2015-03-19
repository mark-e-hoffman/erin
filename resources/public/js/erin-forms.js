function closeForm(elem) {

    $('#'+elem).hide();
}
function renderTemplate(name, data, target) {
    dust.render(name, data, function (err, out) {
        if ( err )
            console.log("renderTemplate ERROR:" + err);
        else {
            $(target).html(out);
        }
    });
}

function setupForm( name, func, update) {
    var formName = '#' + name + '-form';
    console.log("setupForm:" + formName + ",update=" + update);
    $(formName).submit(function (event) {
        event.preventDefault();
        func(event, name, formName);
    });
    if ( update ) {
        $(formName + ' #submit-button').html("Update");
    }
}


function compileTemplate(name) {

    return $.ajax("templates/" + name + ".tl", {
        cache: false,
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

function getVersion() {
    return "/v1/";
}
function getVersionedRoot() {
    return getVersion() + "erin/";
}

function postForm(event, entity, formName) {
    event.preventDefault();
    console.log('postForm:' + entity + "," + formName);
    var dataToBeSent = toJSON($(formName).serializeArray());
    return $.ajax({
        type: "POST",
        url: getVersionedRoot() + entity,
        headers: {
            "Content-Type" : "application/json"
        },
        data: dataToBeSent,
        success: function(data) {

           var id = data[0].id;

            if ( id ) {
               window.location.href = getVersion() + "/erin-form.html?entity=" + entity + "&id=" +id;
            } else {
              window.location.reload();
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
            window.location.reload();
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
    $('#main-entity').append(r);


}

function initComboBox(entity, col, displayCols, targetElem, lookup, idCol) {

    console.log('initComboBox:'+ targetElem +',' + lookup +',' + idCol);
    if ( typeof idCol == 'undefined' ) {
        idCol = "id";
    }
    var idValue = $(targetElem).val();
    if ( idValue ) {
       lookupEntityById(entity, idValue, function(data) {
           var content = '';
           for ( var i in displayCols) {
               content += data[displayCols[i]] + " ";
           }
          $(lookup).val(content);
       });
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
                window.location.href = targetElem + ui.item.data;
            }

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

                window.location.href = targetElem + ui.item.data;
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

            renderTemplate(entity, data, '#main-entity');
            setupForm(entity, putForm, true);
            populateRelationships(entity, data, "#list-right");

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

function populateSummary(entity, key, value, target, summary_view) {

    var name = entity + "-summary";
    compileTemplate(name).then( function() {

        var ent = entity;
        if ( summary_view ) {
            ent = summary_view;
        }
        var url = getVersionedRoot() + ent;
        if ( value !== '*') {
            url = url +"?"+ key +"=" +value;
        }
        console.log('url:' + url);
        $.getJSON(url, function (data) {
            renderTemplate(name, data, target);
            if ( data.items[0].id) {
                populateDetail(entity, data[0].id);
            }

        })
        .fail(function (err) {
                if (err.status == 404) {
                   // alert("Cannot locate " + entity + "(s)");
                }

        })
         .error(function (XMLHttpRequest, textStatus, errorThrown) {
                if ( XMLHttpRequest.responseText != "Not Found") {
                    $('#exception').html(XMLHttpRequest.responseText);
                }
         });
        });
}
function syncTabHeaderWidths(source) {

    var table = $(source).find("table");

    var th = table.find("thead tr:first");
    var tr = table.find("tbody tr:first");
    var td_widths = [];
    var th_widths = []
    var pos = 0;
    tr.find("td").each(function() {
        td_widths[pos++] = $(this).width();
        });

    pos = 0;
    th.find("th").each(function() {
        th_widths[pos++] = $(this).width();
    });

    var widths = [];
    var total_width = 0;
    for ( var i = 0;i<td_widths.length;i++) {
        widths[i] = td_widths[i];
        if ( th_widths[i] > td_widths[i]) {
            widths[i]=th_widths[i];
        }
        total_width += widths[i];
    }

    pos = 0;
    th.find("th").each(function() {
        $(this).width(widths[pos++]);
        });
    pos=0;
    tr.find("td").each(function() {
        $(this).width(widths[pos++]);
    });


}
function populateTab(entity, key, value, target, view, links, calling_entity) {

    console.log("populateTab:" + entity);
    var name = entity + "-tab";
    return compileTemplate(name).then( function() {

        var ent = entity;
        if ( view ) {
            ent = view;
        }
        var url = getVersionedRoot() + ent;
        url = url +"?"+ key +"=" +value + "&_limit=20&_offset=0";
         $.getJSON(url, function (data) {
             data.template = name;
             data["calling_entity"] = calling_entity;
            renderTemplate(name, data, target);
            compileTemplate("tab-navigation").then(function() {

                renderTemplate("tab-navigation",data, links)
                syncTabHeaderWidths(target);
            });
        })
            .fail(function (err) {
                if (err.status == 404) {
                    // alert("Cannot locate " + entity + "(s)");
                }

            })
            .error(function (XMLHttpRequest, textStatus, errorThrown) {
                if ( XMLHttpRequest.responseText != "Not Found") {
                    $('#exception').html(XMLHttpRequest.responseText);
                }
            });
    });
}

function populateTabFromLinks(name, url, target) {


    return $.getJSON(url, function (data) {
        renderTemplate(name, data, target);
        compileTemplate("tab-navigation").then(function() {
            data.template = name;
            renderTemplate("tab-navigation",data, links)
            syncTabHeaderWidths(target);
        });
    })
}
function populateRelationships(entity, data, target) {

    var name = entity + "-relationships";
    console.log('populate_relationships with ' + data.person_id);
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
    return lookupEntityById(parent_entity, value, function( data) {
        renderTemplate(entity, filterFields(data, prePopMap), target);
        setupForm(entity,postForm, false);
    });
}

function hideInfoLookup() {
    $('#info-overlay').fadeOut(700);
}



primaryKeyNames = { 'media_types' : 'media_type'};

function getPrimaryKeyName(entity) {
    var id = primaryKeyNames[entity];
    if ( id == undefined) {
        return 'id';
    }
    return id;
}

prefixToTable = { 'pp' : { 'entity' : 'people', columns : ['name']},
    tv : { 'entity' : 'shows', columns : ['show_name']},
    sh : { 'entity' : 'shows', columns : ['show_name']}}


function getInfo(elem, entity, columns) {


    if ( $(elem).val()) {


        if ( $(elem).attr('name') === 'table_id') { //figure out which table to query
             var prefix = $(elem).val().substr(0,2);
            console.log('prefix=' + prefix);
             entity = prefixToTable[prefix].entity;
            columns = prefixToTable[prefix].columns;
        }
        $.getJSON(getVersionedRoot() + entity + "/" + $(elem).val(), function (data) {

            var content = '';
            for ( var i = 0;i<columns.length;i++) {

                content += data[columns[i]];
                content += ' ';
            }
            var primaryKey = getPrimaryKeyName(entity);
               var ln = "<a href=" + getVersion() + "erin-form.html?entity=" + entity + "&" + primaryKey +"=" + $(elem).val() +">" + content + "</a>";
               $('#info-overlay').html(ln);
               $('#info-overlay').addClass('infoBox').show();

                $('#info-overlay').position({
                    my: "left+20",
                    at: "left bottom",
                    of: elem,
                    collision: "flip"
                })

            });

    }

}

function setValue(selector, value) {
    $(selector).val(value);
}




