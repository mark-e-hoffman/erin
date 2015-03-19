<div id="shows-tab">
    <table class="pure-table rows-tables">
        <thead>
        <tr>
            <th><a alt="Add new Show" href="erin-form.html?entity=shows" class="add-entity">+</a></th>
            <th>ID</th>
            <th>Name</th>
            <th>Media Type</th>
            <th>Description</th>
        </tr>
        </thead>

        <tbody>
        {#.items}
        <tr>
            <td></td>
            <td><a href="erin-form.html?entity=shows&id={.id}">{.id}</a></td>
            <td>{.show_name}</td>
            <td>{.media_type}</td>
            <td>{.show_desc}&nbsp;</td>
        </tr>
        {/.items}
        </tbody>
    </table>
</div>
