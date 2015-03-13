<div id="credits-wrapper">
<legend> <a href="erin-form.html?entity=credits" class="add-entity">+</a> Credits</legend>

     <form class="pure-form pure-form-aligned" id="credits-form">
       <fieldset>

    <div class="pure-control-group">
            <label for="id">Id</label>
            <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">

    </div>
     <div class="pure-control-group">
                <label for="table_id">Show</label>
         <input type="hidden" name="table_id" id="table_id"  value="{table_id}">
         <input type="text" name="credits-table_id-search" id="credits-table_id-search" form="XXX"> <img class="lookupIcon">

        </div>
        <div class="pure-control-group">
                    <label for="person_id">Person</label>
            <input type="hidden" name="person_id" id="person_id"  value="{person_id}">
            <input type="text" name="credits-person_id-search" id="credits-person_id-search" form="XXX"> <img class="lookupIcon">


            </div>
    <div class="pure-control-group">
            <label for="character_name">Character Name</label>
            <input type="text" name="character_name" id="character_name" placeholder="Character Name" value="{character_name}">
    </div>
       <div class="pure-control-group">
                    <label for="character_id">Character Id</label>
                    <input type="text" name="character_id" id="character_id" value="{character_id}">

            </div>
           <div class="pure-control-group">
                        <label for="role_id">Role</label>
                        <input type="hidden"  name="role_id" id="role_id"  value="{role_id}">
                        <input type="text" name="credits-role_id-search" id="credits-role_id-search" placeholder="Role" form="XXX"> <img class="lookupIcon">
                </div>

              <div class="pure-control-group">
                            <label for="listed_order">Listed Order</label>
                            <input type="text" name="listed_order" id="listed_order" placeholder="Listed Oder" value="{listed_order}">

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
<script>
    initComboBox("shows", 'show_name', ['show_name'], "#credits-form #table_id", "#credits-table_id-search");
    initComboBox("people", 'name', ['name'], "#credits-form #person_id", "#credits-person_id-search");
    initComboBox("person_roles", 'person_role', ['person_role'], "#credits-form #role_id", "#credits-role_id-search");
</script>


