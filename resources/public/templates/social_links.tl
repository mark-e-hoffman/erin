<div id="social_links-wrapper">

    <legend> <a href="erin-form.html?entity=social_links" class="add-entity">+</a> Social Links</legend>

    <form class="pure-form pure-form-aligned" id="social_links-form">
        <fieldset>

            <div class="pure-control-group">
                <label for="id">Id</label>
                <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">

            </div>
            <div class="pure-control-group">
                <label for="table_id">Table Id</label>
                <input type="text" name="table_id" id="table_id"  onmouseleave="hideInfoLookup();" onmouseover="getInfo('#social_links-form #table_id','?',['?']);" placeholder="Table Id" readonly value="{table_id}"><div class="inline" id='social_links-table_id-search'></div>
            </div>
            <div class="pure-control-group">
                <label for="link_type">Link Type</label>
                <input type="text" name="link_type" id="link_type"  placeholder="Link Type" readonly value="{link_type}"><div class="inline" id='social_links-link_type-search'></div>

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
                <textarea name="description" id="description" form="social_links-form">{description}</textarea>
            </div>
            <div class="pure-control-group">
                <label for="editor_notes">Editor Notes</label>
                <textarea name="editor_notes" id="editor_notes" form="social_links-form">{editor_notes}</textarea>
            </div>

            <div class="pure-control-group">
                <label for="insert_date">Insert Date</label>
                <input type="text" name="insert_date" id="insert_date" placeholder="Insert Date" readonly value="{insert_date}">
            </div>
            <div class="pure-control-group">
                <label for="update_date">Update Date</label>
                <input type="text" name="Update_date" id="update_date" placeholder="Update Date" readonly value="{update_date}">
            </div>
            <div class="pure-controls">
                <button type="submit" id='submit-button' class="pure-button pure-button-primary">Add</button>
            </div>

        </fieldset>
    </form>
</div>


