package core;

import haxe.Int64;
import haxe.ds.StringMap;

// TODO: remove this, chain to be used only during build
interface Chain {
    var isPolymer: Bool;
    var title: String; 
    var children: List<Job>;
    var ID: Null<Int64>;
    var properties: Null<StringMap<String>>;
}