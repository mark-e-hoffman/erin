<div id="people-tab">
    <table class="pure-table rows-tables">
        <thead>
        <tr>
            <th><a alt="Add new Person" href="erin-form.html?entity=people" class="add-entity">+</a></th>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        </thead>

        <tbody>
        {#.items}
        <tr>
            <td></td>
            <td><a href="erin-form.html?entity=people&id={.id}">{.id}</a></td>
            <td>{.name}</td>
            <td>{.email}</td>

        </tr>
        {/.items}
        </tbody>
    </table>
</div>
