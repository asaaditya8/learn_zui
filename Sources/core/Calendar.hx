package core;

enum abstract IType(Int) {
    var EVENT = 0;
    var TASK = 1;
    var O_TASK = 2;
    var HABIT = 3;
    var O_HABIT = 4;
    var DAG = 5;
    var JOB = 6;
}
class Item {
    public var idx : Int;
    public var start : Int;
    public var duration : Int;
    public var type : IType;
    public var parent_idx : Null<Int>;

    public function new(idx : Int, start : Int, duration : Int, type : IType, ?parent_idx : Int) {
        this.idx = idx;
        this.start = start;
        this.duration = duration;
        this.type = type;
        this.parent_idx = parent_idx;
    }
}

class Calendar {
    public var tasks : Tasks;
    // public var tasks_q : Queue<Int>;
    public var overlapping_tasks : Array<Task>;
    public var habits : Array<Habit>;
    public var overlapping_habits : Array<Habit>;
    public var dags : Array<Dag>;
    public var jobs : Array<Job>;
    public var events : Array<Event>;
    public var items : Array<Item>;
    public var overlapping_items : Array<Item>;
    // public var starts : Array<Int>;
    // public var durations : Array<Int>;

    public function new() {
        tasks = new Tasks();
        // tasks_q = new Queue<Int>();
        overlapping_tasks = [];
        habits = [];
        overlapping_habits = [];
        dags = [];
        jobs = [];
        events = [];
        // items = [];
        // starts = [];
        // durations = [];
    }

    public function binary_search(key : Int) : Array<Int> {
        var large : Int = tasks.length -1;
        var small : Int = 0;
        var mid = (small + large) >> 1;

        while (small <= large){
            mid = (small + large) >> 1 ;
            // trace( small, mid, large, " - ", my_list[mid], "~", key );
            if (tasks.get_start(mid) < key){
                small = mid + 1;
            }
            else if (tasks.get_start(mid) > key){
                large = mid - 1;
            }
            else{
                return [mid, -1];
            }
        }

        var value = tasks.get_start(mid);
        var lower = value < key ? mid : mid-1;
        var upper = value > key ? mid : mid+1;
        return [lower, upper];
    }

    public function binary_insert(start: Int, duration: Int){
        if ( tasks.length > 0 ){
            var pos = binary_search(start);
            if (pos[1] == -1) { throw "Can't insert 0"; }
            // left, right = pos;
            
            if (pos[0] < 0){
                if (start + duration > tasks.get_start(pos[1])) { throw "Can't insert 1";}
                tasks.q.insert(0, tasks.length);
            }
            else if (pos[1] >= tasks.length){
                if(start < tasks.get_start(pos[0]) + tasks.get_duration(pos[0])){ throw "Can't insert 2";}
                tasks.q.enqueue(tasks.length);
            }
            else{
                if(start < tasks.get_start(pos[0]) + tasks.get_duration(pos[0])){ throw "Can't insert 3";}
                if(start + duration > tasks.get_start(pos[1])){ throw "Can't insert 4";}
                
                tasks.q.insert(pos[0] + 1, tasks.length);
            }
        }
        else{
            tasks.q.enqueue(tasks.length);
        }
    }

    public function smallest_sub_of_sum(x: Int) : Array<Int> {
        // TODO: this works only for tasks
        for(i in 0...(tasks.length-1)){
            tasks.set_gap(i, tasks.get_start(i+1) - tasks.get_start(i) - tasks.get_duration(i));
        }
        
        var sum = 0;
        var min_size = tasks.length;
        var result = [-1, -1];
 
        var begin = 0;
        var end = 0;
        while (end < (tasks.length-1)) {
            while (sum < x && end < (tasks.length-1)){
                sum += tasks.get_gap(end);
                end++;
            }
 
            while (sum >= x && begin < (tasks.length-1)) {
                if (end - begin < min_size){
                    min_size = end - begin;
                    result[0] = begin; result[1] = end;
                }
                sum -= tasks.get_gap(begin);
                begin++;
            }
        }

        return result;
    }

    public function populate() : Void {
        /*
        Binary insert is for non-overlapping tasks.
        But that is only for the user.
        So, suppose the lists are coming from the database. Assume shuffled.
        Now, we have to prepare today's list.
        Filter the unfinished tasks.
        Sort them and that is the order.
        what does this function have to do?
        */
        // Assumes filtered events, tasks & habits
        for (i in 0...events.length){
            items.push(new Item(i, events[i].start, events[i].duration, EVENT));
        }

        // for (i in 0...tasks.length){
        //     items.push(new Item(i, tasks[i].start, tasks[i].duration, TASK));
        // }

        for (i in 0...habits.length){
            items.push(new Item(i, habits[i].start, habits[i].duration, HABIT));
        }

        for (i => task in overlapping_tasks){
            items.push(new Item(i, task.start, task.duration, O_TASK));
        }

        for (i => habit in overlapping_habits){
            items.push(new Item(i, habit.start, habit.duration, O_HABIT));
        }

        //TODO : DAGS need to calculate upcoming
        // TODO : use ArraySort

        for (i => dag in dags){
            if( !Graph.verify_topsort(dag.graph, [for (i in 0...dag.nodes.length) i]) ){
                var new2old = Graph.topsort(dag.graph);
                var old2new = [for (n => o in new2old) o => n];
                var new_graph = [for (i in 0...new2old.length) new List<Int>()];
                for (n => o in new2old){
                    for( dst in dag.graph[o] ){
                        new_graph[n].add(old2new[dst]);
                    }
                }
                dag.upcoming = old2new[dag.upcoming];
                dag.graph = new_graph;
                var new_nodes = [for (i in new2old) dag.nodes[i]];
                dag.nodes = new_nodes;
            }
            var begin = dag.upcoming;
            for (j => node in dag.nodes) {
                items.push(new Item(j, node.start, node.duration, DAG, i));
            }
        }

        for (i => job in jobs){
            if( !Graph.verify_topsort(job.graph, [for (i in 0...job.nodes.length) i]) ){
                var new2old = Graph.topsort(job.graph);
                var old2new = [for (n => o in new2old) o => n];
                var new_graph = [for (i in 0...new2old.length) new List<Int>()];
                for (n => o in new2old){
                    for( dst in job.graph[o] ){
                        new_graph[n].add(old2new[dst]);
                    }
                }
                job.upcoming = old2new[job.upcoming];
                job.graph = new_graph;
                var new_nodes = [for (i in new2old) job.nodes[i]];
                job.nodes = new_nodes;
            }
            var begin = job.upcoming;
            for (j => node in job.nodes) {
                items.push(new Item(j, node.start, node.duration, JOB, i));
            }
        }

        items.sort((a, b) -> a.start - b.start);
    }

    public function find_and_set_order() : Void {
        var order = 0;

        for (item in items){
            switch item.type {
                case TASK:
                    tasks.set_order(item.idx, order);
                    order += 1;
                case HABIT:
                    habits[item.idx].order = order;
                    order += 1;
                case _:
            }
        }
    }

    public function reorganise(input_time : Int) {
        /*  Sort using order.
            Start at t=input_time/current_time.
            Add duration and **assign** new start time.
            populate again.
            check for overlaps.
        */
        items.resize(0);
        // tasks.sort((a, b) -> a.order - b.order);
        habits.sort((a, b) -> a.order - b.order);

        var i = 0;
        var j = 0;
        while( i < tasks.length && j < habits.length ){
            if(tasks.get_order(i) < habits[j].order){
                items.push(new Item(i, 0, tasks.get_duration(i), TASK));
                i++;
            }else{
                items.push(new Item(j, 0, habits[j].duration, HABIT));
                j++;
            }
        }

        while( i < tasks.length ){ items.push(new Item(i, 0, tasks.get_duration(i), TASK)); }
        while( j < habits.length ){ items.push(new Item(j, 0, habits[j].duration, HABIT)); }

        for (item in items){
            item.start = input_time;
            switch item.type {
                case TASK:
                    tasks.set_start(item.idx , input_time);
                case HABIT:
                    habits[item.idx].start = input_time;
                case _:
            }
            input_time += item.duration;
        }
    }
}