// C++ program
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <stack>
#include <queue>

using namespace std;

// node class
class node {
    public:
        node (int data) {
            this->data = data;
            this->left = nullptr;
            this->right = nullptr;
        }
        node* left;
        node* right;
        int data;
};

// Tree class
class Tree {
    public:
        Tree() {
            this->root = nullptr;
        }

        node* buildTree(int* a, int& index) {
            if(a[index] == 0) {
                index++;
                return nullptr;
            }
            node* current = new node(a[index++]);
            current->left = buildTree(a, index);
            current->right = buildTree(a, index);
            return current;
        }

        // swap function
        int swap(node* n) {
            if(n == nullptr)
                return 0;

            int swapLeft = swap(n->left);
            int swapRight = swap(n->right);

            if(swapLeft == 0 && swapRight == 0)
                return n->data;

            else if(swapLeft == 0 && swapRight != 0) {
                if(swapRight < n->data)
                    swapOp(n);
                return swapRight;
            }

            else if(swapLeft != 0 && swapRight == 0) {
                if(n->data < swapLeft)
                    swapOp(n);
                return swapLeft;
            }

            else {
                if(swapRight < swapLeft)
                    swapOp(n);
                return swapRight;
            }
        }

        // swap operation
        void swapOp(node* n) {
            if(n == nullptr) return;
            node* temp = n->left;
            n->left = n->right;
            n->right = temp;
        }

        // print tree
        void printTree(node* n, int& k) {
            if(n == nullptr)
                return;
            printTree(n->left, k);
            if(k == 1) cout << n->data << endl;
            else cout << n->data << " ";
            k--;
            printTree(n->right, k);
        }
        node* root;
};

// main
int main(int argc, char** argv) {
    if (argc != 2) {
        cerr << "Usage: no valid inputFile!"<< endl;
        return 1;
    }

    ifstream inputFile(argv[1]);

	// open input file
	if (!inputFile.is_open()) {
        cerr << "Error: Unable to open the file!" << endl;
        return 1;
    }

    string str1;
	string str2;

	// read input file
	if(!getline(inputFile, str1)) {
		cerr << "Error: Unable to read first line!" << endl;
		return 1;
	}
	else if(!getline(inputFile, str2)) {
		cerr << "Error: Unable to read second line!" << endl;
		return 1;
	}
    else {
        // size of tree - number of nodes
        int N = stoi(str1);

        // tree
        istringstream iss(str2);

        // store the nodes of the tree in an array
        int n = str2.length();
		int a[n];
        int i=0;
        string token;
        Tree arrangeTree;
		while(getline(iss, token, ' ')) {
            a[i++] = stoi(token);
        }
        i = 0;
        node* arrangeTreeRoot = arrangeTree.buildTree(a, i);
        arrangeTree.swap(arrangeTreeRoot);
        arrangeTree.printTree(arrangeTreeRoot, N);

        // close the input file
        inputFile.close();
        return 0;
    }
}