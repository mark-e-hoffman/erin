
    <div id="artists-wrapper" style="display:block">

    <form class="pure-form pure-form-aligned" id="artists-form">
            <a class="x-button" href="#" onclick="closeForm('artists-wrapper');">X</a>
            <fieldset>
            <legend>Artist - {_msg}</legend>
    <div class="pure-control-group">
            <label for="id">Id</label>
    <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">
            </div>
    <div class="pure-control-group">
        <label for="people_id">People Id</label>
        <input type="text" name="people_id" id="people_id" placeholder="People Id" readonly value="{people_id}">
    </div>
    <div class="pure-control-group">
            <label for="genre">Genre</label>
    <input type="text" name="genre" id="genre" placeholder="Genre" value="{genre}">
            </div>
    <div class="pure-control-group">
            <label for="role">Role</label>
    <input type="text" name="role" id="role" placeholder="Role" value="{role}">
            </div>
    <div class="pure-control-group">
            <label for="band_group">Band/Group</label>
    <input type="text" name="band_group" id="band_group" placeholder="Band/Group" value="{band_group}">
            </div>
    <div class="pure-control-group">
            <label for="title">Title</label>
    <input type="text" name="title" id="title" placeholder="Title" value="{title}">
            </div>
    <div class="pure-controls">
            <button type="submit" id="submit" class="pure-button pure-button-primary">Add</button>
    </div>
    </fieldset>
    </form>

    </div>




