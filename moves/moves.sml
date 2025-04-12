(*
NOTIFICATION!!!
we used stack-overflow and chat-gpt
to guide us on our journey with sml
*)

(* Representation of possible directions and their names *)
val directions = [((~1, 0), "N"), ((~1, 1), "NE"), ((0, 1), "E"), ((1, 1), "SE"), ((1, 0), "S"), ((1, ~1), "SW"), ((0, ~1), "W"), ((~1, ~1), "NW")];

(* Check if the coordinates are within the bounds of the grid *)
fun isValid (x, y, n) =
    x >= 0 andalso x < n andalso y >= 0 andalso y < n;

(* BFS algorithm *)
fun bfs (grid, n) =
    let
        (* Queue implementation using lists *)
        fun enqueue (queue, elem) = queue @ [elem]
        fun dequeue [] = raise Fail "Empty queue"
          | dequeue (x::xs) = (x, xs)

        (* Helper function for BFS *)
        fun bfsHelper ([], _) = "IMPOSSIBLE"
          | bfsHelper (((x, y, path)::queue), visited) =
              if x = n - 1 andalso y = n - 1 then
                  String.concatWith "," (List.rev path)
              else
                  let
                      fun explore ([], newQueue, newVisited) = bfsHelper (newQueue, newVisited)
                        | explore (((dx, dy), dir)::dirs, newQueue, newVisited) =
                            let
                                val newX = x + dx
                                val newY = y + dy
                            in
                                if isValid (newX, newY, n) andalso not (List.exists (fn (vx, vy) => vx = newX andalso vy = newY) visited) andalso Array2.sub (grid, newX, newY) < Array2.sub (grid, x, y) then
                                    explore (dirs, enqueue (newQueue, (newX, newY, dir::path)), (newX, newY)::newVisited)
                                else
                                    explore (dirs, newQueue, newVisited)
                            end
                  in
                      explore (directions, queue, visited)
                  end
    in
        bfsHelper ([(0, 0, [])], [(0, 0)])
    end;

(* Read input from file and parse the grid *)
fun readInput file =
    let
        val instream = TextIO.openIn file
        val n = case TextIO.inputLine instream of
                    NONE => raise Fail "Invalid input"
                  | SOME line => valOf (Int.fromString line)
        val grid = Array2.array (n, n, 0)
        fun readGrid i =
            if i = n then ()
            else case TextIO.inputLine instream of
                    NONE => raise Fail "Invalid input"
                  | SOME line =>
                        let
                            val nums = List.map (fn x => valOf (Int.fromString x)) (String.tokens (fn c => c = #" ") line)
                            val _ = List.appi (fn (j, num) => Array2.update (grid, i, j, num)) nums
                        in
                            readGrid (i + 1)
                        end
    in
        readGrid 0;
        TextIO.closeIn instream;
        (n, grid)
    end;

(* Moves function *)
fun moves fileName =
    let
        val (n, grid) = readInput fileName
        val result = bfs (grid, n)
    in
        if result = "IMPOSSIBLE" then
            print "IMPOSSIBLE\n"
        else
            print ("[" ^ result ^ "]\n")
    end;