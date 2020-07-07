package dashboard;

import kha.graphics2.Graphics;
import kha.System;

import zui.*;


class View {
    var sequenceCreationListener : Void -> Void = null;
	var backListener : Void -> Void = null;
	

    public function new(SequenceCreationListener : Void -> Void, BackListener : Void -> Void) : Void{
        this.sequenceCreationListener = SequenceCreationListener;
		this.backListener = BackListener;
    }

    public function render(ui: Zui, graphics:Graphics) : Void {
		ui.begin(graphics);

		if (ui.window(Id.handle(), 10, 10, System.windowWidth() - 20, System.windowHeight() - 20)) {
        // if( ui.window(Id.handle(), 10, 10, 500, 600) ){
			if (ui.panel(Id.handle({selected: true}), "Dashboard")) {
				for(i in 1...4){
					ui.text('Seq' + Std.string(i));
					var ratios : Array<Float> = [1/3, 1/3, 1/3];
					ui.row(ratios);
					ui.text('Event 1');
					ui.text('Event 2');
					ui.text('Event 3');
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