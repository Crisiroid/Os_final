#include <iostream>
#include <string>

using namespace std;

int main()
{
    string command;
    do
    {
        cout << "Enter a command (ls, cd, mkdir, vim, rm, pwa) or exit: ";
        getline(cin, command);
        if (command == "ls")
        {
            system("ls");
        }
        else if (command == "cd")
        {
            string dir;
            cout << "Enter directory path: ";
            getline(cin, dir);
            system(("cd " + dir).c_str());
        }
        else if (command == "mkdir")
        {
            string dirName;
            cout << "Enter directory name: ";
            getline(cin, dirName);
            system(("mkdir " + dirName).c_str());
        }
        else if (command == "vim")
        {
            string fileName;
            cout << "Enter file name: ";
            getline(cin, fileName);
            system(("vim " + fileName).c_str());
        }
        else if (command == "rm")
        {
            string fileName;
            cout << "Enter file name: ";
            getline(cin, fileName);
            system(("rm " + fileName).c_str());
        }
        else if (command == "pwd")
        {
            system("pwd");
        }
        else if (command != "exit")
        {
            cout << "Invalid command!" << endl;
        }
    } while (command != "exit");

    return 0;
}