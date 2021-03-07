package core;

class Queue<T> {
    public var length(default, null) : Int;
    public var front : Int;
    public var rear : Int;
    public var arr : Array<T>;

    public function new(initialCapacity=16) {
        arr = [for (i in 0...initialCapacity) null];
        length = 0;
        front = -1;
        rear = -1;
    }

    public function enqueue(data : T) : Void { 
        // condition if queue is full 
        length++;
        if ((rear + 1) == arr.length && front == 0){  
            // print("Queue is Full"
            rear++;
            arr.push(data);
        }
        else if (rear + 1 == front){
            front++;
            rear++;
            arr.insert(front, data);
        }
        // condition for empty queue 
        else if (front == -1){  
            front = 0;
            rear = 0;
            arr[rear] = data;
        }
        else{ 
            // next position of rear 
            rear = (rear + 1) % arr.length;
            arr[rear] = data ;
        } 
    }

    public function dequeue() : T { 
        if (front == -1){ 
            // codition for empty queue 
            // print ("Queue is Empty\n") 
            throw "empty!";
        }     
        // condition for only one element 
        else if (front == rear){  
            var temp = arr[front];
            arr[front] = null;
            front = -1;
            rear = -1;
            length = 0;
            return temp;
        }
        else{
            var temp = arr[front];
            arr[front] = null;
            front = (front + 1) % arr.length;
            length--;
            return temp;
        }
    }

    @:op([]) public inline function get(index:Int):T {
        if(index < 0 || index >= length){ throw 'index $index out of bounds.';}
		return arr[(index + front) % arr.length];
	}

    @:op([]) public inline function set(index:Int, val:T):T {
        if(index < 0 || index >= length){ throw 'index $index out of bounds.';}
		return arr[(index + front) % arr.length] = val;
	}

    public inline function insert(pos:Int, x:T):Void {
        pos = (pos + front) % arr.length;
        if(front < rear){
            if( pos < front || pos > rear+1 ){
                throw "trying to insert out of bounds";
            }
        }
        else{
            if( pos > arr.length-1 || pos < 0 ){
                throw "trying to insert out of bounds";
            }
        }
		arr.insert(pos, x);
        rear++;
	}

    public inline function resize(len:Int):Void {
        arr.resize(Math.floor(Math.max(len, Math.max(front+1, rear+1))));
    }

    public inline function toString():String {
        return arr.toString();
  }
}