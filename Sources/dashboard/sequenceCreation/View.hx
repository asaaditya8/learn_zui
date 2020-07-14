package dashboard.sequenceCreation;

import haxe.rtti.CType.TypeApi;
import haxe.io.Int32Array.Int32ArrayData;
import kha.graphics2.Graphics;
import kha.System;

import zui.*;
import zui.MyExt.TlineSeg;


class View {
    var backListener : Void -> Void = null;
	var sequence : Array<TlineSeg>;
	var event_start : Float;
	var event_end : Float;
	var ratios : Array<Float> = [1/3, 1/3, 1/3];

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
				ui.row(ratios);
				ui.text('Start');
				event_start = MyExt.limitedIntInput(ui, Id.handle(), "HH", 2) * 1.0;
				event_start += MyExt.limitedIntInput(ui, Id.handle(), "MM", 2) / 60;
				
				trace('$event_start');

				ui.row(ratios);
				ui.text('Finish');
				event_end = MyExt.limitedIntInput(ui, Id.handle(), "HH", 2) * 1.0;
				event_end += MyExt.limitedIntInput(ui, Id.handle(), "MM", 2) / 60;
				
				trace('$event_end');


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