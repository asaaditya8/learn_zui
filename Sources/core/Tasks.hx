package core;

import haxe.Int64;

class Tasks {
    public var IDs: Array<Int64>; //TODO: to fetch from database
    public var q : Queue<Int>;
    public var starts : Array<Int>;
    public var durations : Array<Int>;
    public var titles : Array<String>;
    public var orders : Array<Int>;
    public var finisheds : Array<Bool>;
    public var rs : Array<Int>;
    public var gs : Array<Int>;
    public var bs : Array<Int>;
    public var gaps : Array<Int>;

    public var length(get, null): Int;

    public function get_length() {
        return q.length;
    }

    public function new() {
        q = new Queue<Int>();
        starts = [];
        durations = [];
        titles = [];
        orders = [];
        finisheds = [];
        rs = [];
        gs = [];
        bs = [];
        gaps = [];
    }

    public function push(start, duration, title, finished=false, ?r, ?g, ?b) {
        this.starts.push(start);
        this.durations.push(duration);
        this.titles.push(title);
        this.finisheds.push(finished);
        this.rs.push(r);
        this.gs.push(g);
        this.bs.push(b);
    }

    public function get_start(i : Int): Int {
        return starts[q.get(i)];
    }

    public function get_duration(i : Int): Int {
        return durations[q.get(i)];
    }
    public function get_title(i : Int): String {
        return titles[q.get(i)];
    }
    public function get_order(i : Int): Int {
        return orders[q.get(i)];
    }
    public function get_finished(i : Int): Bool {
        return finisheds[q.get(i)];
    }
    public function get_r(i : Int): Int {
        return rs[q.get(i)];
    }
    public function get_g(i : Int): Int {
        return gs[q.get(i)];
    }
    public function get_b(i : Int): Int {
        return bs[q.get(i)];
    }
    public function get_gap(i : Int): Int {
        return gaps[q.get(i)];
    }

    public function set_start(i: Int, x: Int): Int {
        starts[q.get(i)] = x;
        return x;
    }
    public function set_duration(i: Int, x: Int): Int {
        durations[q.get(i)] = x;
        return x;
    }
    public function set_title(i: Int, x: String): String {
        titles[q.get(i)] = x;
        return x;
    }
    public function set_order(i: Int, x: Int): Int {
        orders[q.get(i)] = x;
        return x;
    }
    public function set_finished(i: Int, x: Bool): Bool {
        finisheds[q.get(i)] = x;
        return x;
    }
    public function set_r(i: Int, x: Int): Int {
        rs[q.get(i)] = x;
        return x;
    }
    public function set_g(i: Int, x: Int): Int {
        gs[q.get(i)] = x;
        return x;
    }
    public function set_b(i: Int, x: Int): Int {
        bs[q.get(i)] = x;
        return x;
    }
    public function set_gap(i: Int, x: Int): Int {
        gaps[q.get(i)] = x;
        return x;
    }
}