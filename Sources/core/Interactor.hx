package core;

interface Interactor {
    // create
    public function create_sequence() : Chain;
    public function create_event_in_sequence(sequence: Chain, event: Job) : Void;

    public function multiply_sequence(sequence: Chain) : Void;
    public function create_free_event(event: Job) : Void;
    public function add_progress(event: Job) : Void;
    public function add_target(event: Job) : Void;

    // read
    public function read_sequences() : Array<Chain>;
    public function read_sequence(sequence: Chain) : Array<Job>;
    public function read_free_events() : Array<Job>;
    public function read_progress(event: Job) : Float;
    public function read_target(event: Job) : Void;

    // delete
    public function delete_sequences() : Array<Chain>;
    public function delete_sequence() : Void;
    public function delete_event_in_sequence(sequence: Chain, event: Job) : Void;
    public function delete_free_event(event: Job) : Void;
    public function delete_progress(event: Job) : Float;
    public function delete_target(event: Job) : Void;

    // update
    public function update_sequence(sequence: Chain): Void;
    public function update_event_in_sequence(sequence: Chain, event: Job): Void;
    public function update_free_event(event: Job): Void;
    public function update_progress(event: Job) : Float;
    public function update_target(event: Job) : Void;

    public function elongate_event_in_sequence(sequence: Chain, event: Job) : Void;
    public function shift_sequence(sequence: Chain, event: Job) : Void;
}