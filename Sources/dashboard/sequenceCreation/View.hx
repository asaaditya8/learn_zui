package dashboard.sequenceCreation;

import kha.graphics2.Graphics;
import kha.System;

import zui.*;
import zui.MyExt.TlineSeg;


class View {
    var backListener : Void -> Void = null;
	var sequence : Array<TlineSeg>;
	var event_start : Float;
	var event_end : Float;

    public function new(BackListener: Void -> Void) : Void{
		this.backListener = BackListener;
		sequence = new Array<TlineSeg>();
    }

    public function render(ui: Zui, graphics:Graphics) : Void {
        ui.begin(graphics);

		if (ui.window(Id.handle(), 10, 10, System.windowWidth() - 20, System.windowHeight() - 20)) {
        // if( ui.window(Id.handle(), 10, 10, 500, 600) ){
			// Ext.inlineRadio(ui, Id.handle(), ["1", "2", "3"]);
			MyExt.timeline(ui, 0, 24, 24, sequence);
			if(ui.panel(Id.handle({selected: true}), 'Create Event')){
				event_start = ui.slider(Id.handle(), 'Start', 0, 24, false, 1);
				event_end = ui.slider(Id.handle(), 'End', 0, 24, false, 1);
				MyExt.limitedIntInput(ui, Id.handle(), 'Time', 2);
				if(ui.button('Add')){
					var r = 50 + Std.random(141);
					var g = 50 + Std.random(121);
					var b = 50 + Std.random(151);
					sequence.push({from: event_start, to: event_end, color: kha.Color.fromBytes(r, g, b)});
				}
			}
			if(ui.button("Go Back")){
                // page = 2;
                if( backListener != null){
                    backListener();
                }
			}
		}

		ui.end();
		
	}
}