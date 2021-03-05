package core;


class Habit extends Task{
    var count : Int;
    var misses : Int;

    public function new(start, duration, title, overlaps, count, misses) {
        super(start, duration, title, overlaps);
        this.count = count;
        this.misses = misses;
    }
}