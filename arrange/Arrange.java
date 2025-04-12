// NOTIFICATION!!!
// we used stack-overflow and chat-gpt
// to guide us on our journey with java

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Arrange {
    // node class
    public class Node {
        int data;
        Node left;
        Node right;
        // node constructor
        Node(int data) {
            this.data = data;
            this.left = null;
            this.right = null;
        }
    }

    // tree class
    public class Tree {

        Node root;

        // tree constructor
        Tree() {
            this.root = null;
        }

        // buildTree function
        Node buildTree(int[] a, int[] index) {
            if(index[0] >= a.length || a[index[0]] == 0) {
                index[0]++;
                return null;
            }
            Node current = new Node(a[index[0]]);
            index[0]++;
            current.left = buildTree(a, index);
            current.right = buildTree(a, index);
            return current;
        }

        // swap function
        int swap(Node n) {
            if(n == null)
                return 0;
            int swapLeft = swap(n.left);
            int swapRight = swap(n.right);
            // if the current node is a leaf return its data
            if(swapLeft == 0 && swapRight == 0)
                return n.data;
            // if the current node has only right child then
            else if(swapLeft == 0 && swapRight != 0) {
                // if the right child is smaller then swap and return its data
                if(swapRight < n.data)
                    swapOp(n);
                return swapRight;
            }
            // if the current node has only left child then
            else if(swapLeft != 0 && swapRight == 0) {
                // if the parent is smaller then swap and return its data
                if(n.data < swapLeft)
                    swapOp(n);
                return swapLeft;
            }
            // if the current node has both left and right children then
            else {
                // if the right child is smaller then swap and return its data
                if(swapRight < swapLeft)
                    swapOp(n);
                return swapRight;
            }
        }

        // swap operation function
        void swapOp(Node n) {
            if(n == null) return;
            Node temp = n.left;
            n.left = n.right;
            n.right = temp;
        }

        // print tree
        void printTree(Node n, int k) {
            if(n == null)
                return;
            printTree(n.left, k);
            System.out.print(n.data);
            if(k == 1) System.out.print("\n");
            else System.out.print(" ");
            k--;
            printTree(n.right, k);
        }
    }

    // main
    public static void main(String[] args) {
        try {
            if(args.length == 0) {
                System.out.println("No input file!");
                return;
            }
            // read the input file
            String fileName = args[0];
            BufferedReader br = new BufferedReader(new FileReader(fileName));
            // store the size of the tree - number of nodes
            int sizeTree = Integer.parseInt(br.readLine());
            // store the tree into an array
            String secondLine = br.readLine();
            String[] treeStr = secondLine.split(" ");
            int len = treeStr.length;
            int[] a = new int[len];
            for(int i = 0; i < len; i++) {
                a[i] = Integer.parseInt(treeStr[i]);
            }
            int[] i = new int[] {0};
            Arrange myObject = new Arrange();
            // define the arrange tree
            Tree arrangeTree = myObject.new Tree();
            // build the arrange tree
            Node arrangeTreeRoot = arrangeTree.buildTree(a, i);
            // make the necessary swaps
            arrangeTree.swap(arrangeTreeRoot);
            // print the arrange tree
            arrangeTree.printTree(arrangeTreeRoot, sizeTree);
            // close the input file
            br.close();
        } catch(IOException e) {
            e.printStackTrace();
        }
    }
}