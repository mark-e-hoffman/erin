<div id="networks-summary">
    <legend>Networks</legend>
    <ul>
        {#.items}
        <li><a href="javascript:populateDetail('networks','{.id}');">{.network}</a><br/></li>
        {/.items}
    </ul>
</div>
