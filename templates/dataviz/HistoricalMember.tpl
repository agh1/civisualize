{crmTitle string="Historical Memberships"}

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
{literal}
if(!data.is_error){
    var numberFormat = d3.format(".2f");
    var memberCount, pietype, piestatus;
    CRM.$(function($) {
      pietype = dc.pieChart("#type").innerRadius(20).radius(90);
      piestatus = dc.pieChart("#status").innerRadius(20).radius(90);

      memberCount = dc.lineChart("#membermonthlychart");
      var dateFormat = d3.time.format("%Y-%m-%d");
      data.values.forEach(function(d){d.month = dateFormat.parse(d.month)});
      //var monthDate = new Date(data.values.month);
      var min = d3.min(data.values, function(d) { return d.month;} );
      var max = d3.max(data.values, function(d) { return d.month;} );
      var ndx = crossfilter(data.values);
      all = ndx.groupAll();

      var type = ndx.dimension(function(d) {return d.membership_type_name;});
      var typeGroup = type.group().reduceSum(function(d) { return d.count; });

      var status = ndx.dimension(function(d) {return d.membership_status_label;});
      var statusGroup = status.group().reduceSum(function(d) { return d.count; });

      var byMonth = ndx.dimension(function(d) { return d3.time.month(d.month); });
      var totalByMonthGroup = byMonth.group().reduceSum(function(d) { return d.count; });

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

      pietype
          .width(200)
          .height(200)
          .dimension(type)
          .colors(d3.scale.ordinal().range(["#032336","#28536C","#6F8FA2","#113951","#477187","#003923","#267356","#73AC96","#0E563B","#489075"]))
          .group(typeGroup)
          .renderlet(function (chart) {
          });
      piestatus
          .width(200)
          .height(200)
          .dimension(status)
          .colors(d3.scale.ordinal().range(["#cc99ff","#cc33ff","#9966cc","#9933cc","#cc66ff","#9933ff","#cc00ff","#9900cc"]))
          .group(statusGroup)
          .renderlet(function (chart) {
          });

      memberCount.width(850)
        .height(200)
        .transitionDuration(1000)
        .margins({top: 30, right: 50, bottom: 25, left: 40})
        .dimension(byMonth)
        .mouseZoomable(true)
        .x(d3.time.scale().domain([min,max]))
        .xUnits(d3.time.months)
        .elasticY(true)
        .renderHorizontalGridLines(true)
        .legend(dc.legend().x(800).y(10).itemHeight(13).gap(5))
        .brushOn(false)
        //.rangeChart(volumeChart)
        .group(totalByMonthGroup)
        .valueAccessor(function (d) {
            return d.value;
        })
        .yAxisPadding(2)
        .title(function (d) {
            var value = d.value;
            if (isNaN(value)) value = 0;
            return dateFormat(d.key) + "\n" + numberFormat(value);
        });

      dc.renderAll();
    });
}

{/literal}
</script>
