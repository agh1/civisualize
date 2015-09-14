{crmTitle string="Members"}
<div id="ctype" style="width:250px;">
    <strong>{ts}Membership type{/ts}</strong>
    <a class="reset" href="javascript:piectype.filterAll();dc.redrawAll();" style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div id="cstatus" style="width:250px;">
    <strong>{ts}Membership status{/ts}</strong>
    <a class="reset" href="javascript:piecstatus.filterAll();dc.redrawAll();" style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div id="inherited" style="width:250px;">
    <strong>{ts}Membership inherited?{/ts}</strong>
    <a class="reset" href="javascript:pieinherit.filterAll();dc.redrawAll();" style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div id="donor" style="width:250px;">
    <strong>{ts}Made contribution?{/ts}</strong>
    <a class="reset" href="javascript:piedonor.filterAll();dc.redrawAll();" style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div id="membersincechart">
    <strong>{ts}Member since{/ts}</strong>
    <span class="reset" style="display: none;">range: <span class="filter"></span></span>
    <a class="reset" href="javascript:memberSince.filterAll();dc.redrawAll();"
style="display: none;">reset</a>
    <div class="clearfix"></div>
</div>
<div class="clear"></div>

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
var currentData = {crmSQL file="members"};
</script>
{crmScript ext=eu.tttp.civisualize file=js/dataviz/member.js}
