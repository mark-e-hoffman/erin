<div id="shows-wrapper">
<legend>Show</legend>
      <div class="pure-control-group">
        Search By Show Name <div class="inline" id="shows-show_name-search">
     </div>
     <form class="pure-form pure-form-aligned" id="shows-form">
       <fieldset>

    <div class="pure-control-group">
            <label for="id">Id</label>
            <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">

    </div>
    <div class="pure-control-group">
            <label for="show_name">Show Name</label>
            <input type="text" name="show_name" id="show_name" placeholder="Show Name" value="{show_name}">
    </div>
    <div class="pure-control-group">
            <label for="media_type">Media Type</label>
            <input type="text" name="media_type" id="media_type" readonly placeholder="Media Type" value="{media_type}"><div class="inline" id='shows-media_type-search'></div>

    </div>
    <div class="pure-control-group">
            <label for="network_id">Network ID</label>
            <input type="text" name="network_id" id="network_id" readonly placeholder="Network ID" value="{network_id}"><div class="inline" id='shows-network-search'></div>
    </div>
    <div class="pure-control-group">
            <label for="start_year">Start Year</label>
            <input type="text" name="start_year" id="start_year" placeholder="Start Year" value="{start_year}">
    </div>
       <div class="pure-control-group">
                <label for="end_year">End Year</label>
                <input type="text" name="end_year" id="end_year" placeholder="End Year" value="{end_year}">
        </div>
    <div class="pure-control-group">
            <label for="orig_air_date">Original Air Date</label>
            <input type="text" name="orig_air_date" id="orig_air_date" placeholder="Original Air Date" value="{orig_air_date}">
    </div>
    <div class="pure-control-group">
                <label for="release_date">Release Date</label>
                <input type="text" name="release_date" id="release_date" placeholder="Release Date" value="{release_date}">
   </div>
    <div class="pure-control-group">
            <label for="origin_language">Origin Language</label>
            <input type="text" name="origin_language" id="origin_language" placeholder="Origin Language" value="{origin_language}">
     </div>
       <div class="pure-control-group">
                 <label for="origin_country">Origin Country</label>
                 <input type="text" name="origin_country" id="origin_language" placeholder="Origin Country" value="{origin_country}">
          </div>

      <div class="pure-control-group">
                <label for="short_desc">Short Description</label>
                <textarea name="short_desc" id="short_desc" form="shows-form">{show_desc}</textarea>
        </div>

           <div class="pure-control-group">
                        <label for="plot_desc">Plot Description</label>
                        <textarea name="plot_desc" id="plot_desc" form="shows-form">{plot_desc}</textarea>
                </div>
       <div class="pure-control-group">
                 <label for="top_casey">Top Cast</label>
                 <input type="text" name="top_cast" id="top_cast" placeholder="Top Cast" value="{top_cast}">
          </div>

           <div class="pure-control-group">
                        <label for="editor_notes">Editor Notes</label>
                        <textarea name="editor_notes" id="editor_notes" form="shows-form">{editor_notes}</textarea>
                </div>

    <div class="pure-controls">
            <button type="submit" id='submit' class="pure-button pure-button-primary">Add</button>
    </div>
    </div>

    </fieldset>
    </form>
 </div>

