<div id="credits-tab" class="con">
    <table class="pure-table rows-table" id="credits-table">
        <thead class="fixed_headers">
        <tr>
            <th><a alt="Add new credit" href="javascript:addEntity('credits','{calling_entity}');" class="add-entity">+</a></th>
            <th>ID</th>
            <th>Show</th>
            <th>Person</th>
            <th>Character</th>
            <th>Role</th>
         </tr>
        </thead>
        <tbody>
        {#.items}
        <tr>
            <td></td>
            <td><a href="erin-form.html?entity=credits&id={.id}">{.id}</a></td>
            <td><a href="erin-form.html?entity=shows&id={.table_id}">{.show_name}</a></td>
            <td><a href="erin-form.html?entity=people&id={.person_id}">{.person_name}</a></td>
            <td>{.name}</td>
            <td>{.role}</td>
        </tr>
        {/.items}
        </tbody>
    </table>

</div>
