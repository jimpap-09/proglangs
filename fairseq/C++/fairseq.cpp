// C++ program
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

int minDiffSubArray(int* a, int n, int tot_sum) {

	// initialise minDiff
	int minDiff = tot_sum;
	// start from point k
	for(int k = 0; k < n; k++) {
		// initialise prefix_sum
		int prefix_sum = 0;
		// calculate minDiff
		for(int i = k; i < n-1; i++) {
			prefix_sum += a[i];
			int diff = abs((tot_sum - prefix_sum) - prefix_sum);
			if(diff < minDiff) {
				minDiff = diff;
			}
		}
	}

	// return minDiff
	return minDiff;
}

// main
int main(int argc, char** argv) {

	// given input file
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
		// size of array
		int N = stoi(str1);
		// positive integers
		istringstream iss(str2);
		int a[N];
		// total sum
		int tot_sum = 0;
		for(int i=0; i<N; i++) {
			int num;
			iss >> num;
			a[i] = num;
			tot_sum += num;
		}
		// minimum difference
		int minDiff = minDiffSubArray(a, N, tot_sum);
		// close input file
		inputFile.close();
		cout << minDiff << endl;
		return 0;
	}
}