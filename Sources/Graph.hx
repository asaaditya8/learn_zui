class Graph {
    public static function topsort(graph : Array<List<Int>>) : Array<Int> {
        var nNode : Int = graph.length;

        var inDegree : Array<Int> = [for (i in 0...nNode) 0];
        var zeroInd : List<Int> = new List<Int>();
    
        // topsort
        for(src in 0...nNode){
            for(dst in graph[src]){
                inDegree[dst]++;
            }
        }
    
        for(src in 0...nNode){
            if(inDegree[src]==0){
                zeroInd.add(src);
            }
        }
    
        var sortedInd : Array<Int> = [];
        while(!zeroInd.isEmpty()){
            var node =  zeroInd.pop();
            sortedInd.push(node);
            for(dst in graph[node]){
                if(--inDegree[dst]==0){
                    zeroInd.add(dst);
                }
            }
        }
        return sortedInd;
    }

    public static function verify_topsort(graph : Array<List<Int>>, sortedInd : Array<Int>) : Bool {
        var nNode = sortedInd.length;
        var V : Array<Bool> = [for (i in 0...nNode) false];
        for (src in 0...nNode){
            V[src] = true;
            for (dst in graph[src]) {
                if (V[dst]){
                    return false;
                }
            }
        }
        return true;
    }
}