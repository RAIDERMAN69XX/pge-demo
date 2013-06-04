//= require jquery
//= require jquery.flot.min

var Graph = Graph || {};

(function (Graph, $, undefined) {
    var plot,
        data = [],
        series = [],
        maximum;

    Graph.init = function () {
        var $container = $("#placeholder");
        $container.width($(window).width() * 0.9);
        $container.height($(window).height() * 0.8);

        maximum = $container.outerWidth() / 2 || 300;

        series = [
            {
                data: getRandomData(),
                lines: {
                    fill: true
                }
            }
        ];

        plot = $.plot($container, series, {
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
                tickFormatter: function () {
                    return "";
                }
            },
            yaxis: {
                min: 0,
                max: 10
            },
            legend: {
                show: true
            }
        });

        // Create the demo X and Y axis labels

        var yaxisLabel = $("<div class='axisLabel yaxisLabel' style='font-weight: bold; position: relative; left: -25px; top: 125px'></div>")
            .text("Energy Usage (kWh)")
            .appendTo($container);

        // Since CSS transforms use the top-left corner of the label as the transform origin,
        // we need to center the y-axis label by shifting it down by half its width.
        // Subtract 20 to factor the chart's bottom margin into the centering.

        yaxisLabel.css("margin-top", yaxisLabel.width() / 2 - 20);

        // Update the random dataset at 25FPS for a smoothly-animating chart
    }

    Graph.show = function () {
        if (!plot) {
            Graph.init();
        }

        setInterval(function updateRandom() {
            series[0].data = getRandomData();
            plot.setData(series);
            plot.draw();
        }, 1500);
    }

    function getRandomData() {
        if (data.length) {
            data = data.slice(1);
        }

        while (data.length < maximum) {
            var previous = data.length ? data[data.length - 1] : 5;
            
            //var rand = 0.5 + (Math.random() * 5.5);
            //var y = previous + Math.random() - .5;
            //data.push(y < 0 ? 0 : y > 5 ? rand : y);
            
            data.push(Util.getRandNumInRange(0.5, 5));
        }

        // zip the generated y values with the x values
        var res = [];
        for (var i = 0; i < data.length; ++i) {
            res.push([i, data[i]])
        }

        return res;
    }

}(Graph, jQuery));
