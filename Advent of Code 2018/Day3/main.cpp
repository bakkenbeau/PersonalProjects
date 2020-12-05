#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
#include <map>
#include <set>
#include <unordered_set>
#include <stddef.h>
#include <stdlib.h>

using namespace std;

struct Coordinate
{
    long long id;

    int x_value;
    int y_value;

    bool operator==(Coordinate &other)
    {
        if (this->id == other.id)
            return true;
        else
            return false;
    }
    void Print()
    {
        cout << "x: " << x_value << " y: " << y_value << endl;
    }
    Coordinate(int _x, int _y)
    {
        x_value = _x;
        y_value = _y;
        id = (_y * 1000) + _x;
    }
};

struct Claim
{
    int IDNumber;
    int fromLeft;
    int fromTop;
    int width;
    int height;

    Claim()
    {
        IDNumber = 0;
        fromLeft = 0;
        fromTop = 0;
        width = 0;
        height = 0;
    }
};

struct Board
{
    int counter;
    unordered_set<Coordinate> coordinates;

    void CreateCoordinates(Claim &thisClaim)
    {
        for (int i = thisClaim.fromTop; i < thisClaim.fromTop + thisClaim.height; ++i) {
            for (int j = thisClaim.fromLeft; j < thisClaim.fromLeft + thisClaim.width; ++j) {
                Coordinate thisCoordinate(j, i);
                thisCoordinate.Print();
                bool match = false;
                auto got = coordinates.find(thisCoordinate);
                if (got != coordinates.end()) {
                    counter++;
                    match = true;
                }
                if (!match)
                    coordinates.insert(thisCoordinate);
            }
        }
    }

    Board() {counter = 0;}
};

int main() {
    Board board;

    int counter = 1;
    fstream file("Misc.txt");
    string line;
    while (getline(file, line))
    {
        Claim thisClaim;
        stringstream myStream(line);

        string idnum;
        getline(myStream, idnum, ' ');
        idnum = idnum.substr(1);
        thisClaim.IDNumber = stoi(idnum);

        string nothing;
        getline(myStream, nothing, ' ');

        string fromleft;
        getline(myStream, fromleft, ',');
        thisClaim.fromLeft = stoi(fromleft);

        string fromtop;
        getline(myStream, fromtop, ':');
        thisClaim.fromTop = stoi(fromtop);

        string _width;
        getline(myStream, _width, 'x');
        thisClaim.width = stoi(_width);

        string _height;
        getline(myStream, _height, '\r');
        thisClaim.height = stoi(_height);

        board.CreateCoordinates(thisClaim);
        cout << "Added: " << counter << endl;
        counter++;
    }

    cout << board.counter;
    file.close();
    return 0;
}