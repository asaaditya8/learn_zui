package;

import haxe.Int64;
import haxe.ds.Map;

interface Job {
    var ID: Null<Int64>;
    var int_props: Null<Map<String, Int>>;
    var long_props: Null<Map<String, Int64>>;
    var float_props: Null<Map<String, Float>>;
    var bool_props: Null<Map<String, Bool>>;
    var str_props: Null<Map<String, String>>;
}