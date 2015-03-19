<div id="social_links-wrapper">

    <legend> <a href="erin-form.html?entity=social_links" class="add-entity">+</a> Social Links</legend>

    <form class="pure-form pure-form-aligned" id="social_links-form">
        <fieldset>

            <div class="pure-control-group">
                <label for="id">Id</label>
                <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">

            </div>
            <div class="pure-control-group">
                <label for="table_id">Show/Person</label>
                <input type="hidden" name="table_id" id="table_id" value="{table_id}">
                <input type="text" name="social_links_table_id_search" id="social_links_table_id_search" form="XXX"
                       value="{social_links_table_id_search}"> <img id="social_links_table_lookup_icon" class="lookupIcon">
            </div>
            <div class="pure-control-group">
                <label for="link_type">Link Type</label>
                <input type="text" name="link_type" id="link_type"
                       value="{link_type}"> <img id="link_type_lookup_icon" class="lookupIcon">

            </div>
            <div class="pure-control-group">
                <label for="site_value">Site Value (url)</label>
                <input type="text" name="site_value" id="site_value" placeholder="Site Value" value="{site_value}">
            </div>
            <div class="pure-control-group">
                <label for="preference">Preference</label>
                <input type="text" name="preference" id="preference"   placeholder="Preference" value="{preference}">

            </div>
            <div class="pure-control-group">
                <label for="description">Description</label>
                <textarea cols="80" name="description" id="description" form="social_links-form">{description}</textarea>
            </div>
            <div class="pure-control-group">
                <label for="editor_notes">Editor Notes</label>
                <textarea cols="80" name="editor_notes" id="editor_notes" form="social_links-form">{editor_notes}</textarea>
            </div>

            <div class="pure-control-group">
                <label for="insert_date">Insert Date</label>
                <input type="text" name="insert_date" id="insert_date" placeholder="Insert Date" readonly value="{insert_date}">
            </div>
            <div class="pure-control-group">
                <label for="update_date">Update Date</label>
                <input type="text" name="update_date" id="update_date" placeholder="Update Date" readonly value="{update_date}">
            </div>
            <div class="pure-controls">
                <button type="submit" id='submit-button' class="pure-button pure-button-primary">Add</button>
            </div>

        </fieldset>
    </form>
</div>
<script>
    var calling_entity = $.url().param('calling_entity');
    if ( calling_entity) {

        $('#social_links-form #table_id').val($.url().param('table_id'));
        $('#social_links-form #social_links_table_id_search').val($.url().param('social_links_table_id_search'));
        $('#social_links_table_lookup_icon').hide();

    } else {

        initComboBox("shows_and_people", 'table_name', ['table_name'], "#social_links-form #table_id", "#social_links-form #social_links_table_id_search", "table_name");
    }
    initComboBox("social_link_types", 'link_type', ['link_type'], "#social_links-form #link_type", "#social_links-form #link_type","link_type");

</script>


