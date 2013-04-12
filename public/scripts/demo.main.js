(function () {
  // initialize at 0, change every 2 seconds
  $('.dial').val(0).trigger('change').delay(2000);

  var myColor = 'red';

  var myKnob = $(".dial").knob({
    'min' : 0,
    'max' : 100,
    'readOnly' : true,
    'width' : 250,
    'height' : 250,
    'angleOffset' : 200,
    'angleArc' : 240,
    'fgColor' : myColor,
    'dynamicDraw' : true,
    'thickness' : 0.1,
    'tickColorizeValues' : true,
    'skin' : 'tron',
  })

  var data = [ 13, 45, 23, 56, 43, 76, 35, 20, 34, 12, 80 ];

  function readData() {

    // Circulate the data through the array
    firstPoint = data[0];
    data = data.slice(1);
    data.push(firstPoint);

    return firstPoint;
  }

  var tmr = self.setInterval(function() {
    myDelay()
  }, 1000);
  
  var m = 0;
  
  function myDelay() {
    m = readData();

    if (m >= 0 && m < 25)
      myColor = 'rgba(0, 255, 0, 0.7)';
    else if (m >= 25 && m < 75)
      myColor = 'rgba(255,255,0, 1)';
    else if (m >= 75 && m <= 100)
      myColor = 'rgba(255, 0, 0, 0.7)';

    $('.dial').trigger('configure', {
      'fgColor' : myColor
    });
    $('.dial').css('color', 'black');
    $('.kwh').css('color', 'black');
    $('.dial').val(m).trigger('change');
  }
}());
