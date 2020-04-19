import kha.Color;
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

class Project {
    public var ui: Zui;
    
    public function new(): Void {
        // setFullWindowCanvas();

        ui = new Zui({font: Assets.fonts.Abel_Regular, scaleFactor: 4});
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
        if( ui.window(Id.handle(), 0, 500, 1024, 768) ){
            if(ui.check(Id.handle(), "Hello!")) {
                ui.text("World!");
            }
            ui.slider(Id.handle(), 'Volume', 0, 300, false, 1);
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