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

<script>
var currentData = {crmSQL file="members"};
{literal}
if(!currentData.is_error){
    var numberFormat = d3.format(".2f");
    var memberSince, piectype, piecstatus, pieinherit, piedonor;
    CRM.$(function($) {
      memberSince = dc.barChart("#membersincechart");
      piectype = dc.pieChart("#ctype").innerRadius(20).radius(90);
      piecstatus = dc.pieChart("#cstatus").innerRadius(20).radius(90);
      pieinherit = dc.pieChart("#inherited").innerRadius(20).radius(90);
      piedonor = dc.pieChart("#donor").innerRadius(20).radius(90);

      var dateFormat = d3.time.format("%Y-%m-%d");
      currentData.values.forEach(function(d){d.joinyear = dateFormat.parse(d.joinyear)});
      //var monthDate = new Date(data.values.month);
      var min = d3.time.month.offset(d3.min(currentData.values, function(d) { return d.joinyear;} ), -6);
      var max = d3.time.month.offset(d3.max(currentData.values, function(d) { return d.joinyear;} ), 6);
      var ndx = crossfilter(currentData.values);
      all = ndx.groupAll();

      var ctype = ndx.dimension(function(d) {return d.membership_type_name;});
      var ctypeGroup = ctype.group().reduceSum(function(d) { return d.count; });

      var cstatus = ndx.dimension(function(d) {return d.membership_status_label;});
      var cstatusGroup = cstatus.group().reduceSum(function(d) { return d.count; });

      var inherited = ndx.dimension(function(d) {return d.inherited;});
      var inheritedGroup = inherited.group().reduceSum(function(d) { return d.count; });

      var donor = ndx.dimension(function(d) {return d.donor;});
      var donorGroup = donor.group().reduceSum(function(d) { return d.count; });

      var byYear = ndx.dimension(function(d) { return d3.time.year(d.joinyear); });
      var totalByYearGroup = byYear.group().reduceSum(function(d) { return d.count; });

      var group=ndx.groupAll().reduce(
          function(a, d) {
              a.count += d.count;
              return a;
          },
          function(a, d) {
              a.count -= d.count;
              return a;
          },
          function() {
              return {total:0, count:0};
          }
      );

      piectype
          .width(200)
          .height(200)
          .dimension(ctype)
          .colors(d3.scale.ordinal().range(["#032336","#28536C","#6F8FA2","#113951","#477187","#003923","#267356","#73AC96","#0E563B","#489075"]))
          .group(ctypeGroup)
          .renderlet(function (chart) {
          });

      piecstatus
          .width(200)
          .height(200)
          .dimension(cstatus)
          .colors(d3.scale.ordinal().range(["#cc99ff","#cc33ff","#9966cc","#9933cc","#cc66ff","#9933ff","#cc00ff","#9900cc"]))
          .group(cstatusGroup)
          .renderlet(function (chart) {
          });

      pieinherit
          .width(200)
          .height(200)
          .dimension(inherited)
          .colors(d3.scale.ordinal().range(["#84C600","#6D7759"]))
          .group(inheritedGroup)
          .renderlet(function (chart) {
          });

      piedonor
          .width(200)
          .height(200)
          .dimension(donor)
          .colors(d3.scale.ordinal().range(["#D46900","#80705F"]))
          .group(donorGroup)
          .renderlet(function (chart) {
          });

      memberSince.width(850)
          .height(200)
          .margins({top: 0, right: 50, bottom: 20, left:40})
          .dimension(byYear)
          .group(totalByYearGroup)
          .centerBar(true)
          .gap(1)
          .x(d3.time.scale().domain([min, max]))
          .round(d3.time.year.round)
          .xUnits(d3.time.years);

      dc.renderAll();
    });
}
{/literal}
</script>
