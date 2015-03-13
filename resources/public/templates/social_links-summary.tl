<div id="social_links-summary">
    <legend>Social Links</legend>
    <ul>
        {#.items}
        <li><a href="javascript:populateDetail('social_links','{.id}');">{.link_type}</a><br/></li>
        {.id}<br/>
        {/.items}
    </ul>
</div>
