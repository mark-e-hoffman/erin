<div id="credits-summary">
    <legend>Credits</legend>
    <ul>
        {#.items}
        <li><a href="javascript:populateDetail('credits','{.id}');">{.person_name} as {.name}/{.role}</a><br/></li>
        {/.items}
    </ul>
</div>
