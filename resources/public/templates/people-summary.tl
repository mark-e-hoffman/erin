<div id="people-summary">
    <legend>People</legend>
    <ul>
        {#.items}
        <li><a href="javascript:populateDetail('people','{.id}');">{.name}</a><br/></li>
        {/.items}
    </ul>
</div>
