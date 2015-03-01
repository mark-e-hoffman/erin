 <div id="characters-wrapper">

            <form class="pure-form pure-form-aligned" id="characters-form">
            <a class="x-button" href="#" onclick="closeForm('characters-wrapper');">X</a>
    <fieldset>
    <legend>Character</legend>
    <div class="pure-control-group">
            <label for="id">Id</label>
    <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">
            </div>
    <div class="pure-control-group">
            <label for="people_id">People Id</label>
    <input type="text" name="people_id" id="people_id" placeholder="People Id" readonly value="{people_id}">
            </div>
    <div class="pure-control-group">
            <label for="character_name">Genre</label>
    <input type="text" name="character_name" id="character_name" placeholder="Character Name" value="{character_name}">
            </div>

    <div class="pure-control-group">
            <label for="notes">Notes</label>
            <textarea name="notes" id="notes" form="characters-form">{notes}</textarea>
    </div>


    <div class="pure-controls">
            <button type="submit" id="submit" class="pure-button pure-button-primary">Add</button>
    </div>
    </fieldset>
    </form>

    </div>
