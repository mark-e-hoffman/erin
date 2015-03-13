<div id="characters-summary">
    <legend>Characters</legend>
    <ul>
        {#.items}
        <li><a href="javascript:populateDetail('characters','{.id}');">{.character_name}</a><br/></li>
        {/.items}
    </ul>
</div>
