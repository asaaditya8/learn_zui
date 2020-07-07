package dashboard;

import kha.graphics2.Graphics;
import zui.*;

import dashboard.sequenceCreation.Presenter in SeqCreatePresenter;

class Presenter {
    var sequenceCreation : SeqCreatePresenter;
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

        if(sequenceCreation != null){
            sequenceCreation.render(ui, graphics);
        }
    }

    public function onStart() {
        attachMyView();
    }

    public function attachMyView() {
        myView = new View(openSequenceCreation, backListener);
    }

    public function detachMyView() {
        myView = null;
    }

    public function attachSequenceCreation() {
        sequenceCreation = new SeqCreatePresenter(closeSequenceCreation);
    }

    public function detachSequenceCreation() {
        sequenceCreation = null;
    }

    public function openSequenceCreation() {
        detachMyView();
        attachSequenceCreation();
    }

    public function closeSequenceCreation() {
        detachSequenceCreation();
        attachMyView();
    }
}