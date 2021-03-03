package core;

import haxe.Int64;
import haxe.ds.Map;

class Event {
    var ID: Null<Int64>; //TODO: to fetch from database
    var start : Int;
    var duration : Int;
    var title : String;
    // might overlap
    // might repeat
}