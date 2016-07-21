<!-- <?xml version="1.0" encoding="UTF-8"?> -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <!--  <xsl:template match="/"> -->
  <xsl:template name="directory">
    <html>
    <head>
      <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
      <script type="text/javascript" src="https://www.google.com/jsapi"></script>
      <script type="text/javascript">
        var dataArray = [
          ['Budget Year', 'Budget Amount']
        ];

        var total = 0.0;
        $.getJSON('https://data.raleighnc.gov/resource/pyet-ht2q.json', function(_data, status) {
          $.each(_data, function(index, element) {
            var year = element['budget_year'];
            var amount = parseFloat(element['sum_budget_amount']);
            dataArray.push([year, amount]);          
          });
          var budgetArray = _data.map(i => parseFloat(i['sum_budget_amount']));
          total = budgetArray.reduce(function(a, b) {
            return a + b;
          });
        });

        google.load("visualization", "1.1", {packages:["bar"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
          var data = google.visualization.arrayToDataTable(dataArray);
          var options = {
            chart: {
              title: 'City of Raleigh Budget Totals',
            },
            legend: { position: 'none' },
            bars: 'horizontal'
          };
          var chart = new google.charts.Bar(document.getElementById('chart_div'));
          chart.draw(data, options);
        }
      </script>
    </head>
    <body>
      <div class="container">
        <div class="row">
          <div class="col-md-4 col-md-offset-1">
            <div id="chart_div"></div>
          </div>
          <div class="col-md-4 col-md-offset-1">
            <h2>Open Raleigh Data</h2>
            <p>
              This graph shows City of Raleigh adopted budgets for 2012 - 2016 fiscal years, including interdepartmental transfer amounts. The 2016 budget was adopted June 16th, 2015 city council meeting.
            </p>
            <a href="https://data.raleighnc.gov/Fiscal-Year-2016/FY12-FY16-City-of-Raleigh-Budget-Totals-Chart-/pyet-ht2q">Dataset</a>
          </div>
        </div>
      </div>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
