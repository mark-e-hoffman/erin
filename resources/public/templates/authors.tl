 <div id="authors-wrapper">

            <form class="pure-form pure-form-aligned" id="authors-form">
            <a class="x-button" href="#" onclick="closeForm('authors-wrapper');">X</a>
    <fieldset>
    <legend>Author - {_msg}</legend>
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
            <label for="imdb_name">IMDB Name</label>
    <input type="text" name="imdb_name" id="imdb_name" placeholder="IMDB Name" value="{imdb_name}">
            </div>
    <div class="pure-control-group">
            <label for="title">Title</label>
    <input type="text" name="title" id="title" placeholder="Title" value="{title}">
            </div>
    <div class="pure-control-group">
            <label for="isbn10">ISBN 10</label>
            <input type="text" name="isbn10" id="isbn10" placeholder="ISBN 10" value="{isbn10}">
    </div>
    <div class="pure-control-group">
            <label for="isbn13">ISBN 13</label>
            <input type="text" name="isbn13" id="isbn13" placeholder="ISBN 13" value="{isbn13}">
     </div>
    <div class="pure-control-group">
            <label for="asin">ASIN</label>
    <input type="text" name="asin" id="asin" placeholder="ASIN" value="{asin}">
            </div>
    <div class="pure-control-group">
            <label for="book_description">Book Description</label>
            <textarea name="book_description" id="book_description" form="authors-form">{book_description}</textarea>
    </div>


    <div class="pure-controls">
            <button type="submit" id="submit" class="pure-button pure-button-primary">Add</button>
    </div>
    </fieldset>
    </form>

    </div>
