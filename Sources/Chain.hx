package;

import haxe.Int64;
import haxe.ds.StringMap;

interface Chain {
    var isPolymer: Bool;
    var title: String; 
    var children: List<Job>;
    var ID: Null<Int64>;
    var properties: Null<StringMap<String>>;
}