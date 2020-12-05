#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <map>
using namespace std;

struct DeviceCalibrationTest
{
    int totalChange;
    vector<int> resultingFrequencyList;
    vector<int> Frequencies;
    vector<int> seenResults;

    void AddFrequency(bool positive, int number)
    {
        if(positive) {
            totalChange += number;
            Frequencies.push_back(number);
        }
        else {
            totalChange -= number;
            int thisNum = 0 - number;
            Frequencies.push_back(thisNum);
        }
        resultingFrequencyList.push_back(totalChange);
    }
    bool CheckPreviousTerms(int number)
    {
        for (int i = 0; i < seenResults.size(); i++)
        {
            if (number == seenResults[i]) {
                return true;
            }
        }
        return false;
    }
    void CheckForDuplicate()
    {

        int sum = 0;
        bool found = false;
        while (!found)
        {
            for (int i = 0; i < Frequencies.size(); i++)
            {
                sum += Frequencies[i];
                found = CheckPreviousTerms(sum);
                if (found)
                    break;

                seenResults.push_back(sum);
            }
        }
    }
    DeviceCalibrationTest() {totalChange = 0;}
};

int main() {
    DeviceCalibrationTest test1;

    fstream file("Data.txt");
    if (!file.is_open())
        cout << "Not Open" << endl;

    string line;
    while (getline(file, line))
    {
        char c;
        stringstream myStream(line);
        string frequency;
        bool positive;
        myStream.get(c);
        if (c == '+')
            positive = true;
        else
            positive  = false;

        while (myStream.get(c))
        {
            frequency += c;
        }
        int frequencyNumber = stoi(frequency);
        test1.AddFrequency(positive, frequencyNumber);
    }
    cout << test1.totalChange;
    test1.CheckForDuplicate();

    file.close();

    return 0;
}