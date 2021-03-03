package core;

import haxe.Int64;
import haxe.ds.Map;

class Task {
    var ID: Null<Int64>; //TODO: to fetch from database
    var start : Int;
    var duration : Int;
    var title : String;
    // shiftable
    // might make DAG
    // might overlap
    // might repeat
}