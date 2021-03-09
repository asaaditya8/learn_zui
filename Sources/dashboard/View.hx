package dashboard;

import zui.Zui.Align;
import core.Calendar;
import kha.graphics2.Graphics;
import kha.System;

import zui.*;


class View {
    var sequenceCreationListener : Void -> Void = null;
	var backListener : Void -> Void = null;
	var r = 3;
	var ratio : Array<Float>;
	

    public function new(SequenceCreationListener : Void -> Void, BackListener : Void -> Void) : Void{
        this.sequenceCreationListener = SequenceCreationListener;
		this.backListener = BackListener;
		ratio = [for (i in 0...r) 1/r];
    }

	public function update(): Void {
		
	}

    public function render(ui: Zui, graphics:Graphics, data: Calendar) : Void {
		ui.begin(graphics);

		if (ui.window(Id.handle(), 10, 10, System.windowWidth() - 20, System.windowHeight() - 20)) {
        // if( ui.window(Id.handle(), 10, 10, 500, 600) ){
			if (ui.panel(Id.handle({selected: true}), "Dashboard")) {
				ui.text('Tasks');
				var i = 0;
				while(i + r < data.tasks.length){
					ui.row(ratio);
					for(j in 0...r){
						ui.text(data.tasks.get_title(i+j), Align.Center);
					}
					i += r;
				}
				ui.row(ratio);
				for(j in i...data.tasks.length){
					ui.text(data.tasks.get_title(j), Align.Center);
				}
				for(j in data.tasks.length...(i+r)){
					ui.text("", Align.Center);
				}

			}
	
			if(ui.panel(Id.handle({selected: true}), "Actions")){
				var ratios : Array<Float> = [1/2, 1/2];
				ui.row(ratios);
	
				if(ui.button("Create New Sequence")){
					// go to another page
                    // page = 3;
                    sequenceCreationListener();
				}
	
				ui.button("Add Free Event");
	
				if(ui.button("Go Back")){
                    // page = 1;
                    backListener();
				}
			}
		}

		ui.end();
    }
}