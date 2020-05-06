package;

import kha.System;
import kha.Color;
import kha.Display;

enum abstract Device(Int) {
    var Laptop = 0;
    var Tablet = 1;
    var Mobile = 2;
}

class Length {

    public function new() {
        
    }

    public function ppi() : Int {
        return Display.primary.pixelsPerInch;
    }

    public function scr_w_in() : Int {
        var dpi = ppi();
        var width = cast(Display.primary.width, Float);
        width /= dpi;
        // width *= 25.4;
        return Math.floor(width);
    }

    public function scr_h_in() : Int {
        var dpi = ppi();
        var height = cast(Display.primary.height, Float);
        height /= dpi;
        // height *= 25.4;
        return Math.floor(height);
    }

    public function device_type() : Device {
        var height = scr_h_in();
        var width = scr_w_in();
        var diagonal = Math.sqrt(Math.pow(height, 2) + Math.pow(width, 2));

        if(diagonal > 13){
            return Laptop;
        }
        else if(diagonal > 7){
            return Tablet;
        }
        else {
            return Mobile;
        }
    }
}