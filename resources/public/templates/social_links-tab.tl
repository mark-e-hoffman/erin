<div id="social_links-tab">
    <table class="pure-table rows-tables">
        <thead>
        <tr>
            <th><a alt="Add new credit" href="javascript:addEntity('social_links','{calling_entity}');" class="add-entity">+</a></th>
            <th>ID</th>
            <th>Link Type</th>
            <th>Site Value</th>
            <th>Description</th>
        </tr>
        </thead>

        <tbody>
        {#.items}
        <tr>
            <td></td>
            <td><a href="erin-form.html?entity=social_links&id={.id}">{.id}</a></td>
            <td>{.link_type}</td>
            <td><a target="_blank" href="{.site_value}">{.site_value}</a></td>
            <td>{.description}&nbsp;</td>
        </tr>
        {/.items}
        </tbody>
    </table>
</div>
