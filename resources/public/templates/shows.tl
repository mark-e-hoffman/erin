<div id="shows-wrapper">
    <legend><a href="erin-form.html?entity=shows" class="add-entity">+</a> Show</legend>

    <form class="pure-form pure-form-aligned" id="shows-form">
      <table>
          <tr>
              <td>
            <div class="form-panel-float-left">
                <div class="pure-control-group">
                    <label for="id">Id</label>
                    <input type="text" name="id" id="id" placeholder="Id" readonly value="{id}">

                </div>
                <div class="pure-control-group">
                    <label for="show_name">Show Name</label>
                    <input type="text" name="show_name" id="show_name" value="{show_name}">

                </div>
                <div class="pure-control-group">
                    <label for="media_type">Media Type</label>
                    <input type="hidden" name="media_type" id="media_type" placeholder="Media Type" value="{media_type}">
                    <input type="text" name="shows_media_type_search" id="shows_media_type_search" form="XXX"> <img
                        class="lookupIcon">

                </div>
                <div class="pure-control-group">
                    <label for="network_id">Network</label>
                    <input type="hidden" name="network_id" id="network_id" value="{network_id}">
                    <input type="text" name="shows_network_search" id="shows_network_search" form="XXX"> <img
                        class="lookupIcon">
                </div>
                <div class="pure-control-group">
                    <label for="start_year">Start Year</label>
                    <input type="text" maxlength="4" name="start_year" id="start_year" placeholder="Start Year"
                           value="{start_year}">
                </div>
                <div class="pure-control-group">
                    <label for="end_year">End Year</label>
                    <input type="text" maxlength="4" name="end_year" id="end_year" placeholder="End Year" value="{end_year}">
                </div>
            </div>
             </td>
              <td>
            <div class="form-panel-float-left">
                <div class="pure-control-group">
                    <label for="orig_air_date">Original Air Date</label>
                    <input type="text" name="orig_air_date" id="orig_air_date" placeholder="Original Air Date"
                           value="{orig_air_date}">

                </div>
                <div class="pure-control-group">
                    <label for="release_date">Release Date</label>
                    <input type="text" name="release_date" id="release_date" placeholder="Release Date" value="{release_date}">
                </div>
                <div class="pure-control-group">
                    <label for="origin_language">Origin Language</label>
                    <input maxlength="2" type="text" name="origin_language" id="origin_language" placeholder="Origin Language"
                           value="{origin_language}">
                </div>
                <div class="pure-control-group">
                    <label for="origin_country">Origin Country</label>
                    <input maxlength="2" type="text" name="origin_country" id="origin_country" placeholder="Origin Country"
                           value="{origin_country}">
                </div>
            </div>
             </td>
              </tr>
            <tr>
                <td colspan="2">
         <div class="form-panel">
            <div class="pure-control-group">
                <label for="short_desc">Short Description</label>
                <textarea cols="80" name="short_desc" id="short_desc" form="shows-form">{short_desc}</textarea>
            </div>

            <div class="pure-control-group">
                <label for="plot_desc">Plot Description</label>
                <textarea cols="80" name="plot_desc" id="plot_desc" form="shows-form">{plot_desc}</textarea>
            </div>
            <div class="pure-control-group">
                <label for="top_cast">Top Cast</label>
                <input size="80" type="text" name="top_cast" id="top_cast" placeholder="Top Cast" value="{top_cast}">
            </div>

            <div class="pure-control-group">
                <label for="editor_notes">Editor Notes</label>
                <textarea cols="80" name="editor_notes" id="editor_notes" form="shows-form">{editor_notes}</textarea>
            </div>

         </div>
                    </td>
                </tr>
          </table>

            <div class="pure-controls">
                <button type="submit" id='submit-button' class="pure-button pure-button-primary">Add</button>
            </div>


</form>
</div>

<script>
    $(function () {
        $("#shows-form #orig_air_date").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
    $(function () {
        $("#shows-form #release_date").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
    initComboBox("media_types", 'media_type', ['media_type'], "#shows-form #media_type", "#shows_media_type_search", "media_type");
    initComboBox("networks", 'network', ['network'], "#shows-form #network_id", "#shows_network_search");
</script>


