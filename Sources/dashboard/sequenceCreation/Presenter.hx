package dashboard.sequenceCreation;

import core.Calendar;
import kha.graphics2.Graphics;
import zui.*;

class Presenter {

    var myView : View;
    var backListener : Void -> Void = null;


    public function new(BackListener: Void -> Void) : Void {
        this.backListener = BackListener;
        onStart();
    }

    public function update():Void {
		if(myView != null){
            myView.update();
		}
	}

    public function render(ui: Zui, graphics:Graphics, data: Calendar) : Void {
        if(myView != null){
            myView.render(ui, graphics, data);
        }
    }

    public function onStart() {
        attachMyView();
    }

    public function attachMyView() {
        myView = new View(backListener);
    }

    public function detachMyView() {
        myView = null;
    }
}