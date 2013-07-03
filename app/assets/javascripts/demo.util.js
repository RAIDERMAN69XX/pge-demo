//= require jquery

var Util = Util || {};

(function (Util, $, undefined) {
  
    var previous,
        counter = 0;

    Util.getRandNumInRange = function (min, max) {
      //if (counter % 2 != 0) {
        var numInRange = Math.random() * (max - min) + min;
        previous = previous || numInRange;
        var newNum = previous + Math.random() - .5;

        previous = (newNum < min ? min : newNum > max ? numInRange : newNum);
      //}
      
      return previous;
    }

}(Util, jQuery));
