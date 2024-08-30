#ifndef USER_CLASS_H
#define USER_CLASS_H

constexpr int MAX_USERS = 100; 

enum class menu_enum
{
    Add_user = 1 ,
    Fetch_use ,
    Exit
};

class user_class 
{
    private:
  
    int id = 0;
    std::array <std::string, MAX_USERS> user_name;
    std::array <int, MAX_USERS> user_age;

    public:

    void print_menu (void);
    void add (void);
    void fetch (void);
};

#endif