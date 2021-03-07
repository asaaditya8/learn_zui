package core;

import haxe.Int64;

class Task {
    public var ID: Null<Int64>; //TODO: to fetch from database
    public var start : Int;
    public var duration : Int;
    public var title : String;
    public var overlaps : Bool;
    public var order : Null<Int>;
    public var finished : Bool;
    public var r : Null<Int>;
    public var g : Null<Int>;
    public var b : Null<Int>;

    // shiftable
    public function new(start, duration, title, overlaps, finished=false, ?r, ?g, ?b) {
        this.start = start;
        this.duration = duration;
        this.title = title;
        this.overlaps = overlaps;
        this.finished = finished;
        this.r = r;
        this.g = g;
        this.b = b;
    }
}