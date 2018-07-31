# Mars Rover Challenge
This app is written in plain Ruby and uses MiniTest as the testing framework.
`minitest-reporters` is used display the test output in a documentation format, similar to RSpec.

## Assumptions
* The lower bound of the grid will always start at 0, 0.
* The input format will always be lines of strings
	* The rover's position will be separated by spaces, eg. 1 2 N
	* The movement instructions is a series of instructions without spaces, eg. LMRMLMMRM
* If a movement instruction is invalid, it will be skipped and valid instructions following it will be executed
* A movement instruction is invalid if:
	* It does not contain one of the allowed movements: L, R, M
	* A movement instruction moves the rover off the grid

## Setup
To set up the app, run the following from the root directory of the project:
```
$ bundle install
```

The app was written on `ruby 2.5.1p57` but it should work on any version > 2.

You can change the ruby version in the `.ruby-version` file if you don't want to install `ruby 2.5.1`.
Remember to still run `bundle install` if you do this.

## Running the app
To run the app, first create an input file with the following format:

* The first line of input is the upper-right coordinates of the grid
* The rest of the input is information pertaining to the rovers
* Each rover has two lines of input
	1. The first line gives the rover's position, eg. 1 2 N
	2. The second line is a series of movement instructions, eg. LMRMMLLM
* Sample input files, `input.txt` and `input_2.txt`have also been provided

Example Input File:
```
3 3
1 1 E
LMRMRMLM
```

Once the input file has been created, run the following command from the root directory of the project to run the app:
```
$ ruby run.rb <input_file>
```

Example of running the app using the provided sample input file:
```
$ ruby run.rb input.txt
```

Expected output of sample input file:
```
Grid size: 5 5

Rover 1
Start position: 1 2 N
Movement set  : LMLMLMLMM
Final position: 1 3 N

Rover 2
Start position: 3 3 E
Movement set  : MMRMMRMRRM
Final position: 5 1 E
```

## Running the tests
Tests for the testing the logic of the app have also been written and can be run by executing the following command from the root directory of the project:
```
$ ruby rover_test.rb
```
