
import "./jquery-3.6.1.min.js"

setInterval(function() {
    $('timout-bar').css('width', $('timout-bar').css('width') - 0.1);
}, 16);