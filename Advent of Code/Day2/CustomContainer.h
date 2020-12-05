#ifndef DAY2_CUSTOMCONTAINER_H
#define DAY2_CUSTOMCONTAINER_H
#include <map>
#include <iostream>
using namespace std;

struct CustomContainer
{
    map<char, int> container;
    void Add(const char &letter, const int &data)
    {
        container.emplace(letter, data);
    }
    bool Exists(const char letter)
    {
        auto iter = container.begin();
        while (iter != container.end())
        {
            if (iter->first == letter)
                return true;
            else
                iter++;
        }
        return false;
    }
    void Increment(const char letter)
    {
        auto iter = container.find(letter);
        if (iter != container.end())
            iter->second++;
    }
    bool HasTwos()
    {
        for (auto iter = container.begin(); iter != container.end(); iter++)
        {
            if (iter->second == 2)
                return true;
        }
        return false;
    }
    bool HasThrees()
    {
        for (auto iter = container.begin(); iter != container.end(); iter++)
        {
            if (iter->second == 3)
                return true;
        }
        return false;
    }

    CustomContainer() {}
};

#endif //DAY2_CUSTOMCONTAINER_H
