package core;

import haxe.Int64;

class Dag {
    public var ID: Null<Int64>; //TODO: to fetch from database
    public var graph : Array<List<Int>>;
    public var nodes : Array<Task>;
    public var upcoming : Int;

    public function get_upcoming() : Task{
        return this.nodes[upcoming];
    }
}