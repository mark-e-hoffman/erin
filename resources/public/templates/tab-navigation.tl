<div id="tab-navigation">

    <table class="tab-navigation">

        <tr class="tab-navigation">
            {#links}
            <td id="tab-navigation-cell">
                    {@eq key="href" value="#"}
                        <span class="nav-link">{rel}</span>
                    {:else}
                        <a template="{template}" href="{href}" class="nav-link">{rel}</a>
                    {/eq}

            </td>
            {/links}
        </tr>
        </table>
</div>
<script>
    $(".nav-link").click(function (evt) {
        evt.preventDefault();
        populateTabFromLinks($(this).attr('template'), $(this).attr("href"),"#main-tab");
    });
</script>

