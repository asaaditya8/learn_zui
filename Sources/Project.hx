import kha.Color;
import kha.Assets;
import kha.Framebuffer;
import kha.graphics2.Graphics;

import zui.*;

class Project {
    public var ui: Zui;
    
    public function new(): Void {
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
}