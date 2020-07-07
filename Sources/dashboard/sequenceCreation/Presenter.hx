package dashboard.sequenceCreation;

import kha.graphics2.Graphics;
import zui.*;

class Presenter {

    var myView : View;
    var backListener : Void -> Void = null;


    public function new(BackListener: Void -> Void) : Void {
        this.backListener = BackListener;
        onStart();
    }

    public function render(ui: Zui, graphics:Graphics) : Void {
        if(myView != null){
            myView.render(ui, graphics);
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