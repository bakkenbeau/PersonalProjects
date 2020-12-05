#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <sstream>
#include "CustomContainer.h"
using namespace std;

struct IDNumber
{
    bool HasTwo;
    bool HasThree;
    string ID;

    IDNumber()
    {
        HasTwo = false;
        HasThree = false;
        ID = "";
    }
};

struct Warehouse
{
    vector<IDNumber> IDNumbers;
    int NumOfTwos;
    int NumOfThrees;

    void AddID(string line)
    {
        IDNumber thisID;
        thisID.ID = line;
        IDNumbers.push_back(thisID);
    }
    void CountSpecificIDs() {
        for (int i = 0; i < IDNumbers.size(); i++)
        {
            string thisLine = IDNumbers[i].ID;
            CustomContainer letters;
            for (int k = 0; k < thisLine.length(); k++)
            {
                char currentChar = thisLine[k];
                if (letters.Exists(currentChar)) {
                    letters.Increment(currentChar);
                } else {
                    letters.Add(currentChar, 1);
                }
            }
            IDNumbers[i].HasTwo = letters.HasTwos();
            if (IDNumbers[i].HasTwo)
                NumOfTwos++;

            IDNumbers[i].HasThree = letters.HasThrees();
            if (IDNumbers[i].HasThree)
                NumOfThrees++;
        }

    }
    bool FindCorrectBox()
    {
        bool found = false;
        while (!found) {
            int startingCounter = 0;
            for (int i = startingCounter; i < IDNumbers.size(); i++)
            {
                string baseLine = IDNumbers[i].ID;
                for (int k = i + 1; k < IDNumbers.size(); k++)
                {
                    string checkLine = IDNumbers[k].ID;
                    int lettersThatDiffer = 0;
                    int index = 0;
                    for (int letter = 0; letter < baseLine.length(); letter++)
                    {
                        if (baseLine[letter] != checkLine[letter]) {
                            lettersThatDiffer++;
                            index = letter;
                        }
                    }
                    if (lettersThatDiffer == 1) { //FOUND
                        string finalLine = "";
                        finalLine = baseLine.substr(0, index);
                        finalLine += baseLine.substr(index + 1);
                        cout << finalLine;
                        return true;
                    }
                }
            }
            found = true;
        }
        return false;
    }

    Warehouse(){
        NumOfThrees = 0;
        NumOfTwos = 0;
    }
};

int main() {
    fstream file("Untitled.txt");
    Warehouse warehouse1;

    string line;
    while(getline(file, line))
    {
        warehouse1.AddID(line);
    }
    warehouse1.CountSpecificIDs();
    cout << warehouse1.NumOfTwos * warehouse1.NumOfThrees;
    warehouse1.FindCorrectBox();

    return 0;
}