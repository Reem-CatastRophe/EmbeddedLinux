#include <iostream>
#include <array>
#include "user_class.h"

void user_class::print_menu (void)
{
       
    std:: cout << "Enter an option \n";
    std:: cout << "1. Add user \n";
    std:: cout << "2. Fetch user \n";
    std:: cout << "3. Exit \n";
    
}

void user_class::add (void)
{
        static int i = 0;

        if (i < MAX_USERS)
        {
            std::cout << "Enter your name and age\n";
            std::cout << "Name : ";

            std::cin.ignore();
            std::getline (std::cin, user_name[i]);   // To read until the new line is entered (read the spaces too)

            std::cout << "Age : ";
            std::cin >> user_age[i];
            std::cout << "User added successfully\n";
            std::cout << "User ID is : "<< i << "\n";
            i++;
            id = i;
        }
        else
        {
            std::cout << "## Error: you reached the maximum size\n";
        }
}

void user_class::fetch (void)
{
        int j = 0;
        std::cout<<"Enter the user ID : \n";
        std::cin >> j;

        if (j <= id)
        {
            std::cout<<"User Name is : " << user_name[j] << "\n";
            std::cout<<"User Age is : " << user_age[j] << "\n";
        }
        else
        {
            std::cout<<"## Error : Invalid ID \n";
        }       
}