package core;

enum abstract IType(Int) {
    var EVENT = 0;
    var TASK = 1;
    var HABIT = 2;
    var DAG = 3;
    var JOB = 4;
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
    var tasks : Array<Task>;
    var habits : Array<Habit>;
    var dags : Array<Dag>;
    var jobs : Array<Job>;
    var events : Array<Event>;
    var items : Array<Item>;
    var starts : Array<Int>;
    var durations : Array<Int>;

    public function binary_search(my_list : Array<Int>, key : Int) : Array<Int> {
        var large : Int = my_list.length -1;
        var small : Int = 0;
        var mid = (small + large) >> 1;

        while (small <= large){
            mid = (small + large) >> 1 ;
            // trace( small, mid, large, " - ", my_list[mid], "~", key );
            if (my_list[mid] < key){
                small = mid + 1;
            }
            else if (my_list[mid] > key){
                large = mid - 1;
            }
            else{
                return [mid, -1];
            }
        }

        var value = my_list[mid];
        var lower = value < key ? mid : mid-1;
        var upper = value > key ? mid : mid+1;
        return [lower, upper];
    }

    public function binary_insert(start : Int, duration : Int){
        if ( this.starts.length > 0 ){
            var pos = binary_search(this.starts, start);
            if (pos[1] == -1) { throw "Can't insert"; }
            // left, right = pos;
            
            if (pos[0] < 0){
                if (start + duration <= this.starts[pos[1]]) { throw "Can't insert";}
                this.starts.unshift(start);
                this.durations.unshift(duration);
            }
            else if (pos[1] >= this.starts.length){
                if(start >= this.starts[pos[0]] + this.durations[pos[0]]){ throw "Can't insert";}
                this.starts.push(start);
                this.durations.push(duration);
            }
            else{
                if(start >= this.starts[pos[0]] + this.durations[pos[0]]){ throw "Can't insert";}
                if(start + duration <= this.starts[pos[1]]){ throw "Can't insert";}
                
                this.starts.insert(pos[0] + 1, start);
                this.durations.insert(pos[0] + 1, duration);
            }
        }
        else{
            this.starts.push(start);
            this.durations.push(duration);
        }
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

        for (i in 0...tasks.length){
            items.push(new Item(i, tasks[i].start, tasks[i].duration, TASK));
        }

        for (i in 0...habits.length){
            items.push(new Item(i, habits[i].start, habits[i].duration, HABIT));
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
        var task_id = 0;
        var habit_id = 0;

        for (item in items){
            switch item.type {
                case TASK:
                    tasks[item.idx].order = task_id;
                    task_id += 1;
                case HABIT:
                    habits[item.idx].order = habit_id;
                    habit_id += 1;
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
        
    }
}