$(function() {
/*
  var margin = {top: 20, right: 20, bottom: 30, left: 50},
      width = 960 - margin.left - margin.right,
      height = 500 - margin.top - margin.bottom;
  
  var parseDate = d3.time.format("%Y%m%d").parse;
  
  var x = d3.time.scale()
      .range([0, width]);
  
  var y = d3.scale.linear()
      .range([height, 0]);
  
  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");
  
  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");
  
  var line = d3.svg.area()
      .interpolate("basis")
      .x(function(d) { return x(d.date); })
      .y(function(d) { return y(d["New York"]); });
  
  var area = d3.svg.area()
      .interpolate("basis")
      .x(function(d) { return x(d.date); })
      .y1(function(d) { return y(d["New York"]); });
  
  var svg = d3.select("body").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
  
  d3.tsv("data.tsv", function(error, data) {
    data.forEach(function(d) {
      d.date = parseDate(d.date);
      d["New York"]= +d["New York"];
      d["San Francisco"] = +d["San Francisco"];
    });
  
    x.domain(d3.extent(data, function(d) { return d.date; }));
  
    y.domain([
      d3.min(data, function(d) { return Math.min(d["New York"], d["San Francisco"]); }),
      d3.max(data, function(d) { return Math.max(d["New York"], d["San Francisco"]); })
    ]);
  
    svg.datum(data);
  
    svg.append("clipPath")
        .attr("id", "clip-below")
      .append("path")
        .attr("d", area.y0(height));
  
    svg.append("clipPath")
        .attr("id", "clip-above")
      .append("path")
        .attr("d", area.y0(0));
  
    svg.append("path")
        .attr("class", "area above")
        .attr("clip-path", "url(#clip-above)")
        .attr("d", area.y0(function(d) { return y(d["San Francisco"]); }));
  
    svg.append("path")
        .attr("class", "area below")
        .attr("clip-path", "url(#clip-below)")
        .attr("d", area);
  
    svg.append("path")
        .attr("class", "line")
        .attr("d", line);
  
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);
  
    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Temperature (ºF)");
  });
*/
  var container = $("#placeholder");
  $("#placeholder").width($(window).height() * 0.9);
  $("#placeholder").height($(window).width() * 0.8);

  // Determine how many data points to keep based on the placeholder's initial size;
  // this gives us a nice high-res plot while avoiding more than one point per pixel.

  var maximum = container.outerWidth() / 2 || 300;

  //

  var data = [];

    function getRandomData() {

        if (data.length) {
            data = data.slice(1);
        }

        while (data.length < maximum) {
            var previous = data.length ? data[data.length - 1] : 50;
            var y = previous + Math.random() * 10 - 5;
            data.push(y < 0 ? 0 : y > 100 ? 100 : y);
        }

        // zip the generated y values with the x values

        var res = [];
        for (var i = 0; i < data.length; ++i) {
            res.push([i, data[i]])
        }

        return res;
    }

  //

  series = [{
    data: getRandomData(),
    lines: {
      fill: true
    }
  }];

  //

  var plot = $.plot(container, series, {
    grid: {
      borderWidth: 1,
      minBorderMargin: 20,
      labelMargin: 10,
      backgroundColor: {
        colors: ["#fff", "#e4f4f4"]
      },
      margin: {
        top: 8,
        bottom: 20,
        left: 20
      },
      markings: function(axes) {
        var markings = [];
        var xaxis = axes.xaxis;
        for (var x = Math.floor(xaxis.min); x < xaxis.max; x += xaxis.tickSize * 2) {
          markings.push({ xaxis: { from: x, to: x + xaxis.tickSize }, color: "rgba(232, 232, 255, 0.2)" });
        }
        return markings;
      }
    },
    xaxis: {
      tickFormatter: function() {
        return "";
      }
    },
    yaxis: {
      min: 0,
      max: 110
    },
    legend: {
      show: true
    }
  });

  // Create the demo X and Y axis labels

  var yaxisLabel = $("<div class='axisLabel yaxisLabel' style='font-weight: bold; position: relative; left: -25px; top: 125px'></div>")
    .text("Energy Usage (kWh)")
    .appendTo(container);

  // Since CSS transforms use the top-left corner of the label as the transform origin,
  // we need to center the y-axis label by shifting it down by half its width.
  // Subtract 20 to factor the chart's bottom margin into the centering.

  yaxisLabel.css("margin-top", yaxisLabel.width() / 2 - 20);

  // Update the random dataset at 25FPS for a smoothly-animating chart

  setInterval(function updateRandom() {
    series[0].data = getRandomData();
    plot.setData(series);
    plot.draw();
  }, 2500);
});
