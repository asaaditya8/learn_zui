package;

import zui.MyExt.TlineSeg;
import zui.Zui.Align;
import kha.Sound;
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
import dashboard.Presenter in DashPresenter;
import Length.Length;

class Project {
	public var ui:Zui;
    var myView : View;
    var dashboard : DashPresenter;

	// var LeCalendar : CalendarService;

	var itemList = ["Item 1", "Item 2", "Item 3"];

	var page : Int;
	var go_back : Bool;
	var show_more : Bool;
	var sequence : Array<TlineSeg>;
	var event_start : Float;
	var event_end : Float;

	public function new():Void {
		setFullWindowCanvas();
		var lengths = new Length();
		var device = lengths.device_type();
		var scaleFactor:Float;
		switch device {
			case Laptop:
				scaleFactor = 1.5;
			case Tablet:
				scaleFactor = 3;
			case Mobile:
				scaleFactor = 4;
		}
		ui = new Zui({font: Assets.fonts.Abel_Regular, scaleFactor: scaleFactor});

		// LeCalendar = new CalendarService();
		page = 1;
		show_more = false;
		sequence = new Array<TlineSeg>();

		onStart();
	}

	public function update():Void {}

	public function render(frames:Array<Framebuffer>):Void {
		var graphics = frames[0].g2;
		graphics.begin();
		graphics.end();
		
		if(myView != null){
            myView.render(ui, graphics);
		}
		
		if(dashboard != null){
			dashboard.render(ui, graphics);
		}
	}

	public function onStart() {
        attachMyView();
    }

    public function attachMyView() {
        myView = new View(openDashboard);
    }

    public function detachMyView() {
        myView = null;
    }

    public function attachDashboard() {
        dashboard = new DashPresenter(closeDashboard);
    }

    public function detachDashboard() {
        dashboard = null;
    }

    public function openDashboard() {
        detachMyView();
        attachDashboard();
    }

    public function closeDashboard() {
        detachDashboard();
        attachMyView();
    }

	static function setFullWindowCanvas():Void {
		#if kha_html5
		// make html5 canvas resizable
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
