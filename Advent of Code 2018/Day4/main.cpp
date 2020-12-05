#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>
using namespace std;

struct LogInput {
    int month, day;
    int hour, minute;
    string line;
    void Print() {
        cout << month << " " << day << " " << hour << " " << minute << endl;
    }
};

bool SortingMethod(LogInput &lhs, LogInput &rhs) {
    if (lhs.month < rhs.month) {
        return true;
    } else if (lhs.month == rhs.month) {
        if (lhs.day < rhs.day) {
            return true;
        } else if (lhs.day == rhs.day) {
            if (lhs.hour < rhs.hour) {
                return true;
            } else if (lhs.hour == rhs.hour) {
                if (lhs.minute < rhs.minute) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } else {
            return false;
        }
    } else {
        return false;
    }
}

struct Calendar {
    vector<LogInput> DayInputs;
    void Add(LogInput q) {
        DayInputs.push_back(q);
    }
    void Order() {
        sort(DayInputs.begin(), DayInputs.end(), SortingMethod);
    }
};

struct Guard {
    int ID;
    int minutesAsleep;
};

int main() {
    Calendar calendar;
    ifstream file("Log_Input.txt");

    string line;
    while (getline(file, line)) {
        stringstream myStream(line);
        string year;
        getline(myStream, year, '-');
        string month;
        getline(myStream, month, '-');
        string day;
        getline(myStream, day, ' ');
        string hour;
        getline(myStream, hour, ':');
        string minute;
        getline(myStream, minute, ']');
        LogInput thisInput;
        thisInput.line = line;
        thisInput.month = stoi(month);
        thisInput.day = stoi(day);
        thisInput.hour = stoi(hour);
        thisInput.minute = stoi(minute);
        calendar.Add(thisInput);
    }
    calendar.Order();
    vector<Guard> listOfGaurds;

    ofstream outputFile("Ordered_Input.txt");
    for (int i = 0; i < calendar.DayInputs.size(); i++) {
        outputFile << calendar.DayInputs[i].line << endl;
        if (calendar.DayInputs[i].line.find("Guard") != string::npos) {
            cout << i + 1 << " ";
            Guard guard;
            stringstream myStream(calendar.DayInputs[i].line);
            string trash;
            getline(myStream, trash, '#');
            string ID;
            getline(myStream, ID, ' ');
            guard.ID = stoi(ID);
            listOfGaurds.push_back(guard);
            cout << guard.ID << endl;
        } else if ()
    }

    return 0;
}