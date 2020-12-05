#include <iostream>
using namespace std;

int addition(int one, int two)
{
	int returnValue = one + two;
	return returnValue;
}

int subtraction(int one, int two)
{
	int returnValue = one - two;
	return returnValue;
}

int multiplication(int one, int two)
{
	int returnValue = one * two;
	return returnValue;
}

int division(int one, int two)
{
	int returnValue = one / two;
	return returnValue;
}

int main()
{
	cout << "Choose option and add two integers you would like to";
	cout << " perform the operation on in that order" << endl;
	cout << "a) addition\n";
	cout << "b) subtraction\n";
	cout <<  "c) multiplication\n";
	cout << "d) division" << endl;

	char operation;
	cin >> operation;

	int operand1, operand2;
	cin >> operand1;
	cin >> operand2;

	switch(operation) {
		case 'a': {
			int value = addition(operand1, operand2);
			cout << value;
			break;
		}
		case 'b': {
			int value = subtraction(operand1, operand2);
			cout << value;
			break;
		}
		case 'c': {
			int value = multiplication(operand1, operand2);
			cout << value;
			break;
		}
		case 'd': {
			int value = division(operand1, operand2);
			cout << value;
			break;
		}
	}

	return 0;
}