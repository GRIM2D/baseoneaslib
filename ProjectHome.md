This is a basic toolkit for everyday flash use like:

- Logger class (avoid putting trace commands all over)
- Stopwatch for measuring execution time
- Simple tile-based A-Star implementation
- Basic fps-meter with graph (i like it visual)

Yes I'm lazy, but here's some info

## AStar Notes ##
This following explanation uses the **Flash Player 10** version, using the new FP10 class Vector (which is much faster than using an Array).

All you should need is in package `com.baseoneonline.flash.astar`
The most important types are AStar and Graph.
TileGraph and TileNode are there as an example or maybe it just suits your needs.

### Using the pathfinder ###
This example is using the TileGraph and TileNode classes

Create a grid with 50\*30 tiles using the provided `TileGraph`, a implementation of `Graph`. You could use your own implementation of the `Graph` interface. The graph doesn't have to be a tile grid, implement however you like.
```
var myGraph:TileGraph = new TileGraph(50,30);
```

Now set which tiles are walkable and which are not,
probably looping over the tile data you have loaded before.
This is entirely dependent on how you implement `Graph`, this is (again) just using `TileGraph`
```
for (var x:int=0; x<50; x++) {
  for (var y:int=0; y<30; y++) {
    myGraph.setWalkable(x,y, ?);
  }
}
```

Okay, now we can use the pathfinder, so instantiate it:
```
var astar:AStar = new AStar(myGraph);
```

In order to use the pathfinder, we need to tell it a start and goal position. `AStar` accepts a node index (int). `TileGraph` provides an easy way to get the index based on tile coordinates:
```
var start:int = myGraph.getTileIndex(12, 4);
var goal:int = myGraph.getTileIndex(33, 23);
```

This is enough to finally find a path:
```
var path:Vector.<int> = astar.solve(start, goal);
```

Now what? We have a list of tile indices. But to use it in a game, we need tile coordinates. `TileGraph` has a convenience method to convert this list of integers to a list of `Vec2i` coordinates. Again, this is entirely dependent on how you use the `Graph` interface, in this case we stick with the example `TileGraph`:
```
var usablePath:Vector.<Vec2i> = myGraph.getNodes(path);
```
Now you can do whatever you like with the path, like letting your character walk from start to goal.