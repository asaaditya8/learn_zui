package;

import core.Calendar;
import kha.graphics2.Graphics;
import kha.System;

import zui.*;


class View {
    var dashboardListener : Void -> Void = null;
	var show_more : Bool;

    public function new(DashboardListener : Void -> Void) : Void{
        this.dashboardListener = DashboardListener;
		show_more = false;
    }

	public function update(): Void {
		
	}

	function event_row(ui: Zui, data: Calendar, ratios: Array<Float>, title: String) {
		ui.separator();
		ui.row(ratios);
		ui.text(title);
		if(ui.button('>')){
			data.tasks_q.enqueue(data.tasks_q.dequeue());
		}
		ui.button('+');
		ui.combo(Id.handle(), ['5', '10', '30'], null, false, Center);
		if(ui.button('\\/')){
			show_more = !show_more;
		}
		if(show_more){
			ui.indent();
			ui.row([4/5, 1/5]);
			ui.slider(Id.handle(), 'Progress', 0, 100, true, 1);
			if(ui.button('+')){
				show_more = !show_more;
			}
			ui.unindent();
		}
	}

    public function render(ui: Zui, graphics: Graphics, data: Calendar) : Void {
		ui.begin(graphics);

		if (ui.window(Id.handle(), 10, 10, System.windowWidth() - 20, System.windowHeight() - 20)) {
        // if( ui.window(Id.handle(), 10, 10, 500, 600) ){
			if (ui.panel(Id.handle({selected: true}), "Live")) {
				// ui.text('Seq' + Std.string(i));
				var ratios : Array<Float> = [3/7, 1/7, 1/7, 1/7, 1/7];
				ui.row(ratios);
				ui.text('Event');
				ui.text('Next', Center);
				ui.text('Add', Right);
				ui.text("Time", Left);
				ui.text("", Center);
				if(data.tasks.length > 0){
					event_row(ui, data, ratios, data.tasks[data.tasks_q.get(0)].title);
				}
			}
	
			if(ui.panel(Id.handle({selected: true}), "Actions")){
				// var ratios : Array<Float> = [1/2, 1/2];
				// ui.row(ratios);
	
				if(ui.button("Go To Dashboard")){
					// go to another page
                    // page = 2;
                    dashboardListener();
				}
			}
		}

		ui.end();
	}
}