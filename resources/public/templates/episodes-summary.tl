<div id="episodes-summary">
<legend>Episodes</legend>
<ul>
{#.items}
   <li><a href="javascript:populateDetail('episodes','{.id}');">{.series_num}/{.episode_num} - {.show_name}</a><br/></li>
{/.items}
</ul>
</div>
