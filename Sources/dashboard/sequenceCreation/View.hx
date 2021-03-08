package dashboard.sequenceCreation;

import core.Task;
import haxe.Exception;
import core.Calendar;
import kha.graphics2.Graphics;
import kha.System;

import zui.*;
import MyExt.TlineSeg;


class View {
    var backListener : Void -> Void = null;
	var display_sequence : Array<TlineSeg>;
	var title : String;
	var event_start : Int;
	var event_end : Int;
	var ratios : Array<Float> = [1/3, 1/3, 1/3];
	var toast_str : Null<String> = null;
	var toast_counter : Int = 120;

    public function new(BackListener: Void -> Void) : Void{
		this.backListener = BackListener;
		display_sequence = new Array<TlineSeg>();
    }

	public function update():Void {
		if(toast_str != null){
			toast_counter -= 1;
		}
		if(toast_counter == 0){
			toast_str = null;
			toast_counter = 120;
		}
	}

    public function render(ui: Zui, graphics:Graphics, data: Calendar) : Void {
		if(display_sequence.length == 0){
			for(task in data.tasks){
				display_sequence.push({from: task.start/60, to: (task.start+task.duration)/60, color: kha.Color.fromBytes(task.r, task.g, task.b)});
			}
			
			data.items.resize(0);
			for(i in 0...data.tasks_q.length){
				var j = data.tasks_q.get(i);
				data.items.push(new Item(j, data.tasks[j].start, data.tasks[j].duration, TASK));
				trace(data.tasks[j].start/60, data.tasks[j].duration/60);
			}
		}
        ui.begin(graphics);

		if (ui.window(Id.handle(), 10, 10, System.windowWidth() - 20, System.windowHeight() - 20)) {
        // if( ui.window(Id.handle(), 10, 10, 500, 600) ){
			// Ext.inlineRadio(ui, Id.handle(), ["1", "2", "3"]);
			MyExt.timeline(ui, 0, 24, 12, display_sequence);
			if(ui.panel(Id.handle({selected: true}), 'Using Time')){
				title = ui.textInput(Id.handle(), "Title");
				ui.row(ratios);
				ui.text('Start');
				event_start = MyExt.limitedIntInput(ui, Id.handle(), "HH", 2) * 60;
				event_start += MyExt.limitedIntInput(ui, Id.handle(), "MM", 2);
				
				ui.row(ratios);
				ui.text('Finish');
				event_end = MyExt.limitedIntInput(ui, Id.handle(), "HH", 2) * 60;
				event_end += MyExt.limitedIntInput(ui, Id.handle(), "MM", 2);

				if(ui.button('Add')){
					var r = 50 + Std.random(141);
					var g = 50 + Std.random(121);
					var b = 50 + Std.random(151);
					try {
						var item = new Item(data.tasks.length, event_start, event_end - event_start, TASK);
						data.binary_insert(item);
						data.tasks.push(new Task(event_start, event_end - event_start, title, false, r, g, b));
						display_sequence.push({from: event_start/60.0, to: event_end/60.0, color: kha.Color.fromBytes(r, g, b)});
					} catch(e) {
						put_toast(e.toString());
					}
				}
			}
			if(ui.panel(Id.handle({selected: false}), 'Squeeze & Fit')){
				title = ui.textInput(Id.handle(), "Title");
				ui.row(ratios);
				ui.text('Duration');
				var event_duration = MyExt.limitedIntInput(ui, Id.handle(), "HH", 2) * 60;
				event_duration += MyExt.limitedIntInput(ui, Id.handle(), "MM", 2);
				if(ui.button('Add')){
					var r = 50 + Std.random(141);
					var g = 50 + Std.random(121);
					var b = 50 + Std.random(151);
					var pos = data.smallest_sub_of_sum(data.tasks_q, event_duration);
					trace('pos', pos);
					if(pos[0] == -1){
						put_toast("Can't insert");}
					else {
						var max_idx = pos[0];
						var total_gap = 0;
						{
						var max_gap = -1;
						for (i in pos[0]...pos[1]){
							var gap = data.tasks[data.tasks_q.get(i)].gap;
							total_gap += gap;
							if( gap > max_gap ) { max_gap = gap; max_idx = i;};
						}
						}
						trace('max_idx', max_idx);
						total_gap -= event_duration;
						// data.items.insert(max_idx+1, new Item(data.tasks.length, event_start, event_duration, TASK));
						data.tasks_q.insert(max_idx+1, data.tasks.length);
						// trace('new', event_start, event_duration);
						trace(data.tasks_q.arr);
						data.tasks.push(new Task(event_start, event_duration, title, false, r, g, b));

						data.tasks[data.tasks_q.get(pos[0]+1)].start = data.tasks[data.tasks_q.get(pos[0])].start + data.tasks[data.tasks_q.get(pos[0])].duration;
						if(max_idx > (pos[1]+pos[0]) >> 1){
							data.tasks[data.tasks_q.get(pos[0]+1)].start += total_gap;
						}
						else if(max_idx == (pos[1]+pos[0]) >> 1){
							data.tasks[data.tasks_q.get(pos[0]+1)].start += (total_gap >> 1);
						}
						// trace('task', data.tasks[data.tasks_q.get(pos[0]+1)].start/60, data.tasks[data.tasks_q.get(pos[0]+1)].duration/60, data.tasks[data.tasks_q.get(pos[0]+1)].title);
						for(i in (pos[0]+2)...(pos[1]+2)){
							data.tasks[data.tasks_q.get(i)].start = data.tasks[data.tasks_q.get(i-1)].start + data.tasks[data.tasks_q.get(i-1)].duration;
						}
						if(max_idx < (pos[1]+pos[0]) >> 1 ){
							data.tasks[data.tasks_q.get(pos[1]+1)].start += total_gap;
						}
						else if(max_idx == (pos[1]+pos[0]) >> 1){
							data.tasks[data.tasks_q.get(pos[1]+1)].start += (total_gap >> 1);
						}

						display_sequence.resize(0);
					}
				}
			}
			if(ui.button("Go Back")){
                // page = 2;
				for(i in 0...data.tasks_q.length){data.tasks_q.dequeue();}
				for(item in data.items){data.tasks_q.enqueue(item.idx);}
				for(i in 0...(data.tasks_q.length-1)){
					var j = data.tasks_q.get(i);
					var k = data.tasks_q.get(i+1);
					data.tasks[j].gap = data.tasks[k].start - data.tasks[j].start - data.tasks[j].duration;
				}

                if( backListener != null){
                    backListener();
                }
			}
			if(toast_str != null){ MyExt.toast(ui, toast_str); }
		}

		ui.end();
		
	}

	inline function put_toast(s: String) {
		toast_str = s;
	}
}