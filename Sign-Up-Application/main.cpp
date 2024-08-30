/************************************** Dependencies *************************************/
#include <iostream>
#include <string>
#include <array>
#include "user_class.h"  
/*****************************************************************************************/

/********************************* Operator Overloading **********************************/
std::istream& operator >> (std::istream& input_stream, menu_enum& option)
{
    int int_option = 0;

    input_stream >> int_option;

    option = static_cast<menu_enum> (int_option);

    return input_stream;
}


/************************************** Entry Point **************************************/
int main()
{
    user_class user;
    menu_enum option = menu_enum::Add_user; 
    bool not_exit = true;

    while (not_exit)
    {
        user.print_menu();

        std::cin >> option;

        switch (option)
        {
            case menu_enum::Add_user:
                user.add();
                break;
            case menu_enum::Fetch_use:
                user.fetch();
                break;
            case menu_enum::Exit:
                not_exit = false;
                std::cout << "Good Bye :) \n";
                break;
            default:
            std::cout<<"Invalid option\n";
        }
    }   
}