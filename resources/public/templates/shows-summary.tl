<div id="shows-summary">
<legend>Show</legend>
<ul>
{#.items}
   <li><a href="javascript:populateDetail('shows','{.id}');">{.show_name}</a><br/></li>
   {.id}<br/>
{/.items}
</ul>
</div>
