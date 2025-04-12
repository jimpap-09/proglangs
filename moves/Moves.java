// NOTIFICATION!!!
// we used stack-overflow and chat-gpt
// to guide us on our journey with java

// java libraries for FileReader, BufferedReader, System.out, Queue, List
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

// Moves class
public class Moves {
    // directions to which i can go from a current node
    private static final int[] DX = {-1, -1, 0, 1, 1, 1, 0, -1};
    private static final int[] DY = {0, 1, 1, 1, 0, -1, -1, -1};
    private static final String[] DIRECTIONS = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"};
    
    // main function
    public static void main(String[] args) throws IOException {
        // FileReader to read the input file
        // BufferedReader to read each line of the input file
        BufferedReader br = new BufferedReader(new FileReader(args[0]));
        // Read the first line of the input file
        int N = Integer.parseInt(br.readLine());
        int[][] grid = new int[N][N];
        
        // Read the plane from the input file and store it into the grid
        for (int i = 0; i < N; i++) {
            String[] line = br.readLine().split(" ");
            for (int j = 0; j < N; j++) {
                grid[i][j] = Integer.parseInt(line[j]);
            }
        }
        // use bfs to find the path
        String result = bfs(grid, N);

        // print the path
        System.out.println(result);

        // close the input file
        br.close();
    }
    
    // bfs function
    private static String bfs(int[][] grid, int N) {
        boolean[][] visited = new boolean[N][N];
        Queue<Node> queue = new LinkedList<>();

        // we add the first node (0,0) to the queue with null path
        queue.add(new Node(0, 0, new ArrayList<>()));
        visited[0][0] = true;

        // while we have not checked all visited nodes
        while (!queue.isEmpty()) {
            // we check the first node of the queue
            Node current = queue.poll();
            
            // if its the goal node return its path
            if (current.x == N - 1 && current.y == N - 1) {
                return formatPath(current.path);
            }

            // for each direction check the next node
            for (int i = 0; i < 8; i++) {
                int newX = current.x + DX[i];
                int newY = current.y + DY[i];
                
                /*
                if the next node completes the below requirements:
                is valid (is in the grid)
                is not visited (is not in the queue)
                has less value from the current node
                then visit it (add it to the queue)
                */ 

                if (isValid(newX, newY, N) && !visited[newX][newY] && grid[newX][newY] < grid[current.x][current.y]) {
                    visited[newX][newY] = true;
                    List<String> newPath = new ArrayList<>(current.path);
                    newPath.add(DIRECTIONS[i]);
                    queue.add(new Node(newX, newY, newPath));
                }
            }
        }
        // else return IMPOSSIBLE
        return "IMPOSSIBLE";
    }

    // Node class
    static class Node {
        int x, y;
        List<String> path;

        // Node constructor
        Node(int x, int y, List<String> path) {
            this.x = x;
            this.y = y;
            this.path = path;
        }
    }

    // isValid function
    private static boolean isValid(int x, int y, int N) {
        return x >= 0 && x < N && y >= 0 && y < N;
    }

    // formatPath function
    private static String formatPath(List<String> path) {
        return path.toString().replace(", ", ",");
    }
}