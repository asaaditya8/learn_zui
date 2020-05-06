package;

import haxe.Constraints.FlatEnum;
import kha.ScreenCanvas;
import kha.ScreenRotation;
import kha.System;
import kha.Color;
import kha.Display;
import kha.Assets;
import kha.Framebuffer;
import kha.graphics2.Graphics;
#if kha_html5
import kha.Macros;
import js.html.CanvasElement;
import js.Browser.document;
import js.Browser.window;
#end

import zui.*;
import Length.Length;

class Project {
    public var ui: Zui;
    
    public function new(): Void {
        setFullWindowCanvas();
        var lengths = new Length();
        var device = lengths.device_type();
        var scaleFactor : Float;
        switch device {
            case Laptop: scaleFactor = 1.5;
            case Tablet: scaleFactor = 3;
            case Mobile: scaleFactor = 4;
        }
        ui = new Zui({font: Assets.fonts.Abel_Regular, scaleFactor: scaleFactor});
    }

	public function update(): Void {
	}

	public function render(frames: Array<Framebuffer>): Void {
        var graphics = frames[0].g2;
        graphics.begin();
        graphics.end();
        gui(graphics);
    }
    
    public function gui(graphics: Graphics) : Void {
        ui.begin(graphics);
        
        // if( ui.window(Id.handle(), 10, 10, System.windowWidth()-20, System.windowHeight()-20) ){
        if( ui.window(Id.handle(), 10, 10, 100, 300) ){
            if(ui.check(Id.handle(), "Hi, Click me to say Hello!")) {
                ui.text("World!");
            }
            ui.slider(Id.handle(), 'Volume', 0, 300, false, 1);
            ui.text(Std.string(Display.primary.pixelsPerInch)+'ppi');
            ui.text(Std.string(Display.primary.height)+' height');
            ui.text(Std.string(Display.primary.width)+' width');
            ui.text(Std.string(Display.primary.name)+' name');
            ui.text(Std.string(System.screenRotation)+' degree');
            ui.text(Std.string(System.windowHeight())+' height');
            ui.text(Std.string(System.windowWidth())+' width');
            ui.text(Std.string(ScreenCanvas.the.height)+' height');
            ui.text(Std.string(ScreenCanvas.the.width)+' width');
        }

        if( ui.window(Id.handle(), 410, 110, 150, 100) ){
            if(ui.check(Id.handle(), "Hello!")) {
                ui.text("World!");
            }
            ui.text(Std.string(Display.primary.pixelsPerInch)+'ppi');
        }
        ui.end();
    }

    

    static function setFullWindowCanvas():Void {
		#if kha_html5
		//make html5 canvas resizable
		document.documentElement.style.padding = "0";
		document.documentElement.style.margin = "0";
		document.body.style.padding = "0";
		document.body.style.margin = "0";
		var canvas:CanvasElement = cast document.getElementById(Macros.canvasId());
		canvas.style.display = "block";

		var resize = function() {
			canvas.width = Std.int(window.innerWidth * window.devicePixelRatio);
			canvas.height = Std.int(window.innerHeight * window.devicePixelRatio);
			canvas.style.width = document.documentElement.clientWidth + "px";
			canvas.style.height = document.documentElement.clientHeight + "px";
		}
		window.onresize = resize;
		resize();
		#end
	}
}