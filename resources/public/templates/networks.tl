<div id="networks-wrapper">
    <legend> <a href="erin-form.html?entity=networks" class="add-entity">+</a> Network</legend>
    <form class="pure-form pure-form-aligned" id="networks-form">
        <fieldset>

            <div class="pure-control-group">
                <label for="id">Id</label>
                <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">
            </div>
            <div class="pure-control-group">
                <label for="network">Name</label>
                <input type="text" name="network" id="network" placeholder="Name" value="{network}"><div class="inline" id='networks-network-search'>
            </div>
            <div class="pure-control-group">
                <label for="country">Country</label>
                <textarea name="country" id="country" form="networks-form">{country}</textarea>
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
                <button type="submit" id='submit' class="pure-button pure-button-primary">Add</button>
            </div>
        </fieldset>
    </form>
</div>
