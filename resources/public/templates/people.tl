<div id="people-wrapper">
<legend> <a href="erin-form.html?entity=people" class="add-entity">+</a> Person</legend>
<form class="pure-form pure-form-aligned" id="people-form">
       <fieldset>

    <div class="pure-control-group">
            <label for="id">Id</label>
            <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">
    </div>
    <div class="pure-control-group">
            <label for="name">Name</label>
            <input type="text" size="40" name="name" id="name" placeholder="Name" value="{name}">
    </div>
    <div class="pure-control-group">
            <label for="person_note">Note</label>
            <textarea name="person_note" cols="80" id="person_note" form="people-form">{person_note}</textarea>
    </div>
    <div class="pure-control-group">
            <label for="personal_wiki">Personal Wiki</label>
            <input type="text" size="40" name="personal_wiki" id="personal_wiki" placeholder="Personal Wiki" value="{personal_wiki}">
    </div>
    <div class="pure-control-group">
            <label for="home_town">Home Town</label>
            <input type="text" name="home_town" id="home_town" placeholder="Home Town" value="{home_town}">
    </div>
    <div class="pure-control-group">
            <label for="email">Email</label>
            <input type="text" name="email" id="email" placeholder="Email" value="{email}">
    </div>
    <div class="pure-control-group">
            <label for="full_name">Full Name</label>
            <input type="text" name="full_name" id="full_name" placeholder="Full Name" value="{full_name}">
     </div>
    <div class="pure-control-group">
            <label for="birthdate">Birth Date</label>
            <input type="text" name="birthdate" id="birthdate" placeholder="Birth Date" value="{birthdate}">
     </div>
    <div class="pure-control-group">
            <label for="deathdate">Death Date</label>
            <input type="text" name="deathdate" id="deathdate" placeholder="Death Date" value="{deathdate}">
     </div>


    <div class="pure-controls">
            <button type="submit" id='submit-button' class="pure-button pure-button-primary">Add</button>
    </div>
    </fieldset>
    </form>
</div>
<script>
    $(function () {
        $("#people-form #birthdate").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
    $(function () {
        $("#shows-form #deathdate").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
 </script>


