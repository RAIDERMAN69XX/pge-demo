//= require jquery
//= require jquery.flot.min
//= require jquery.flot.axislabels

var Graph = Graph || {};

(function (Graph, $, undefined) {
  var plot,
    options = {},
    data = [],
    series = [],
    maximum,

    $container;

  Graph.init = function () {
    $container = $("#placeholder");
    $container.width($(window).width() * 0.9);
    $container.height($(window).height() * 0.8);

    //maximum = $container.outerWidth() / 2 || 300;
    maximum = 100;

    series = [ {
        data: getRandomData(),
        lines: {
          fill: true
        }
      } ];

    options = {
      grid: {
        borderWidth: 1,
        minBorderMargin: 20,
        labelMargin: 10,
        backgroundColor: {
          colors: [ "#fff", "#fff" ]
          //colors: [ "#fff", "#e4f4f4" ]
        },
        margin: {
          top: 20,
          bottom: 20,
          left: 25,
          right: 25
        },
        markings: function (axes) {
          var markings = [];
          var xaxis = axes.xaxis;
          for (var x = Math.floor(xaxis.min); x < xaxis.max; x += xaxis.tickSize * 2) {
            markings.push({ xaxis: { from: x, to: x + xaxis.tickSize }, color: "rgba(232, 232, 255, 0.2)" });
          }
          return markings;
        }
      },
      xaxis: {
        tickFormatter: function (val, axis) {
          var localeTime = new Date(val).toLocaleTimeString();
          var hms = localeTime.split(':');
          var ampm;

          if (hms[0] <= 12) {
            if (hms[0] == 0) {
              hms[0] = 12;
            }
            ampm = 'AM';
          } else {
            hms[0] = hms[0] - 12;
            ampm = 'PM';
          }

          return hms.join(':') + ' ' + ampm;
        },
        axisLabel: "Time",
        axisLabelUseCanvas: true,
        axisLabelFontSizePixels: 12,
        axisLabelFontFamily: 'Verdana, Arial',
        axisLabelPadding: 5
      },
      yaxis: {
        min: 0,
        max: 10,
        axisLabel: 'Energy usage in kW/H',
        axisLabelUseCanvas: true,
        axisLabelFontSizePixels: 12,
        axisLabelFontFamily: 'Verdana, Arial',
        axisLabelPadding: 5
      },
      lines: {
        show: true
      },
      points: {
        show: true
      },
      legend: {
        show: true
      }
    };

    plot = $.plot($container, series, options);
  }

  Graph.show = function () {
    if (!plot) {
      Graph.init();
    }

    setInterval(function updateRandom() {
      series[0].data = getRandomData();
      $.plot($container, series, options);
    }, 1000);
  }

  function getRandomData() {
    if (data.length) {
      data = data.slice(1);
    }

    while (data.length < maximum) {
      data.push(Util.getRandNumInRange(1.5, 6.5));
    }

    // zip the generated y values with the x values
    var res = [];
    var currentTime = new Date().getTime();
    var startTime = currentTime - (data.length * 1000);
    for (var i = 0; i < data.length; ++i) {
      res.push([startTime, data[i]])
      startTime += 1000;
    }

    return res;
  }

}(Graph, jQuery));
