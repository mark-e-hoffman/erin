<div id="episodes-tab">
<table class="pure-table">
    <thead>
    <tr>
        <th><a alt="Add new credit" href="javascript:addEntity('episodes');" class="add-entity">+</a></th>
        <th>ID</th>
        <th>Name</th>
        <th>Original Air Date</th>
        <th>Series #</th>
        <th>Episode #</th>
        <th>Part #</th>
    </tr>
    </thead>

    <tbody>
    {#.items}
    <tr>
        <td></td>
        <td><a href="erin-form.html?entity=episodes&id={.id}">{.id}</a></td>
        <td>{.show_name}</td>
        <td>{.orig_air_date}</td>
        <td>{.series_num}</td>
        <td>{.episode_num}</td>
        <td>{.part_num}</td>
    </tr>
    {/.items}
    </tbody>
</table>
</div>
