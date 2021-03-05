package core;

import haxe.Int64;
import haxe.ds.Map;

class Event {
    public var ID: Null<Int64>; //TODO: to fetch from database
    public var start : Int;
    public var duration : Int;
    public var title : String;
    public var overlaps : Bool;
    public var repeats : Bool;
    public var order : Null<Int>;
    // might overlap
    // might repeat
}