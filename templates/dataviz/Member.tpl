{crmTitle string="Members"}
<h1>{ts}Historical Memberships{/ts}</h1>
<div id="type" style="width:250px;">
    <strong>{ts}Membership type{/ts}</strong>
    <a class="reset" href="javascript:pietype.filterAll();dc.redrawAll();" style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div id="status" style="width:250px;">
    <strong>{ts}Membership status{/ts}</strong>
    <a class="reset" href="javascript:piestatus.filterAll();dc.redrawAll();" style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div id="membermonthlychart">
    <strong>{ts}Total memberships by month{/ts}</strong>
    <span class="reset" style="display: none;">range: <span class="filter"></span></span>
    <a class="reset" href="javascript:memberCount.filterAll();dc.redrawAll();"
style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div class="clear"></div>

<script>
var data = {crmSQL file="membercount"};
</script>
{crmScript ext=eu.tttp.civisualize file=js/dataviz/member.js}
