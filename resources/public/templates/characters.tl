 <div id="characters-wrapper">

            <form class="pure-form pure-form-aligned" id="characters-form">

    <fieldset>
    <legend> <a href="erin-form.html?entity=characters" class="add-entity">+</a> Character</legend>
    <div class="pure-control-group">
            <label for="id">Id</label>
    <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">
            </div>

    <div class="pure-control-group">
            <label for="character_name">Character Name</label>
    <input type="text" name="character_name" id="character_name" placeholder="Character Name" value="{character_name}"><div class="inline" id='characters-name-search'></div>
            </div>

    <div class="pure-control-group">
            <label for="notes">Notes</label>
            <textarea name="notes" id="notes" form="characters-form">{notes}</textarea>
    </div>

        <div class="pure-control-group">
            <label for="editor_notes">Editor Notes</label>
            <textarea name="editor_notes" id="editor_notes" form="characters-form">{editor_notes}</textarea>
        </div>

    <div class="pure-controls">
            <button type="submit" id="submit" class="pure-button pure-button-primary">Add</button>
    </div>
    </fieldset>
    </form>

    </div>
