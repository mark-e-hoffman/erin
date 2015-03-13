<div id="person_roles-summary">
    <legend>Roles</legend>
    <ul>
        {#.items}
        <li><a href="javascript:populateDetail('person_roles','{.id}');">{.person_role}</a><br/></li>
        {/.items}
    </ul>
</div>
