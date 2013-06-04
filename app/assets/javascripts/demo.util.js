//= require jquery

var Util = Util || {};

(function (Util, $, undefined) {
  
    var previous = 0,
        counter = 0;
        
    Util.getRandNumInRange = function (min, max) {
      if (++counter % 2 != 0) {
        var numInRange = min + (Math.random() * ((max - min) + 1));
        var newNum = previous + Math.random() - .5;
        
        previous = (newNum < 0 ? 0 : newNum > 5 ? numInRange : newNum);
      }
      
      return previous;
    }

}(Util, jQuery));
