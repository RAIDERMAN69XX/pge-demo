//= require gauge

window.onload = function () {
    var gaugeWidth = $(window).width() / 2;

    var usageGauge = new Gauge({
        renderTo: 'usage-gauge',
        width: gaugeWidth,
        height: gaugeWidth,
        maxValue: 10,
        majorTicks: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        glow: true,
        units: 'kWh',
        title: 'Current Usage',
        strokeTicks: true,

        highlights: [
            {
                from: 0,
                to: 2,
                color: 'PaleGreen'
            },
            {
                from: 2,
                to: 5,
                color: 'Khaki'
            },
            {
                from: 5,
                to: 10,
                color: 'LightSalmon'
            }
        ],
        animation: {
            delay: 10,
            duration: 300,
            fn: 'bounce'
        }
    });

    usageGauge.onready = function () {
        usageGauge.setValue(0);
        setInterval(function () {
          usageGauge.setValue(Util.getRandNumInRange(0.5, 5));
          /*
            $.getJSON('/meter_reading', function (result, status) {
                kwh = result.items[0].xadAttributeIntegerValue / 1000;
                usageGauge.setValue(kwh);
            })
          */
        }, 1500);
    };

    usageGauge.draw();
};
