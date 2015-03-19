<div id="episodes-wrapper">
<legend> <a href="erin-form.html?entity=episodes" class="add-entity">+</a> Episodes</legend>
<form class="pure-form pure-form-aligned" id="episodes-form">
    <table>
       <fieldset>
    <tr>
     <td>
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
            <input type="text" name="media_type" id="media_type" readonly placeholder="Media Type" readonly value="tv_episode">

    </div>
    <div class="pure-control-group">
            <label for="network_id">Network ID</label>
            <input type="text" name="network_id" id="network_id" onmouseleave="hideInfoLookup();" onmouseover="getInfo('#episodes-form #network_id','networks',['network']);" readonly placeholder="Network ID" readonly value="{network_id}">
    </div>
     <div class="pure-control-group">
                <label for="series_id">Series ID</label>
                <input type="text" name="series_id" id="series_id" onmouseleave="hideInfoLookup();" onmouseover="getInfo('#episodes-form #series_id','shows',['show_name']);" placeholder="Series ID" readonly value="{series_id}">
        </div>
      </td>
      <td>
    <div class="pure-control-group">
            <label for="start_year">Start Year</label>
            <input type="text" name="start_year" id="start_year" placeholder="Start Year" value="{start_year}">
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
                 <input type="text" name="origin_country" id="origin_country" placeholder="Origin Country" value="{origin_country}">
          </div>
     </td>
      </tr>
       <tr>
           <td colspan="2">
      <div class="pure-control-group">
                <label for="short_desc">Short Description</label>
                <textarea cols="80" name="short_desc" id="short_desc" form="episodes-form">{short_desc}</textarea>
        </div>

           <div class="pure-control-group">
                        <label for="plot_desc">Plot Description</label>
                        <textarea cols="80" name="plot_desc" id="plot_desc" form="episodes-form">{plot_desc}</textarea>
                </div>
       <div class="pure-control-group">
                 <label for="top_cast">Top Cast</label>
                 <input size="80" type="text" name="top_cast" id="top_cast" placeholder="Top Cast" value="{top_cast}">
          </div>

           <div class="pure-control-group">
                        <label for="editor_notes">Editor Notes</label>
                        <textarea cols="80" name="editor_notes" id="editor_notes" form="episodes-form">{editor_notes}</textarea>
                </div>

           <div class="pure-control-group">
                             <label for="series_num">Series Number</label>
                             <input type="text" name="series_num" id="series_num" placeholder="Series Number" value="{series_num}">
                     </div>

               <div class="pure-control-group">
                                 <label for="episode_num">Episode Number</label>
                                 <input type="text" name="episode_num" id="episode_num" placeholder="Episode Number" value="{episode_num}">
                         </div>
           <div class="pure-control-group">
                             <label for="part_num">Part Number</label>
                             <input type="text" name="part_num" id="part_num" placeholder="Part Number" value="{part_num}">
                     </div>
               </td>
           </tr>
       </fieldset>
      </table>

    <div class="pure-controls">
            <button type="submit" id="submit-button"   class="pure-button pure-button-primary">Add</button>
    </div>

    </form>
</div>

<script>
    $(function () {
        $("#episodes-form #orig_air_date").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
    $(function () {
        $("#episodes-form #release_date").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
    initComboBox("media_types", 'media_type', ['media_type'], "#episodes-form #media_type", "#episodes_media_type_search", "media_type");
    initComboBox("networks", 'network', ['network'], "#episodes-form #network_id", "#episodes_network_search");
</script>



