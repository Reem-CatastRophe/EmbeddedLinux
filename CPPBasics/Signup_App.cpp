#include <iostream>
#include <vector>
#include <string>

const int MAX_RECORDS = 100;  // Maximum allowed records

/// Program to manage a simple record system using a class and vector.
/// Users can add and fetch records with a maximum limit of 100 records.

/// Record class definition to hold a person's name and age.
class Record {
public:
    std::string name;  // Name of the person
    int age;           // Age of the person

    // Constructor to initialize Record with name and age
    Record(const std::string& name, int age) : name(name), age(age) {}
};

// Declare a vector to store records with a maximum of 100 entries
std::vector<Record> records;

/// Function to add a new record.
/// @param name The name of the person to add.
/// @param age The age of the person to add.
void AddRecord(const std::string& name, int age) {
    // Check if adding a new record exceeds the limit
    if (records.size() < MAX_RECORDS) {
        records.emplace_back(name, age);  // Add new record to the vector
        std::cout << "Record added successfully!\n";
    } else {
        std::cout << "Error: Maximum number of records reached.\n";
    }
}

/// Function to fetch and display a record by its user ID.
/// @param userID The ID of the user to fetch.
void FetchRecord(int userID) {
    // Check if userID is within the valid range
    if (userID >= 0 && userID < records.size()) {
        Record record = records[userID];  // Get the record at the specified ID
        std::cout << "Record ID: " << userID << "\n";
        std::cout << "Name: " << record.name << ", Age: " << record.age << "\n";
    } else {
        std::cout << "Error: Invalid User ID.\n";
    }
}

/// Main function to display a menu and handle user actions.
int main() {
    int choice;         // User's menu choice
    bool running = true;  // Control variable for main loop

    // Main application loop to handle user interaction
    while (running) {
        // Display menu options to the user
        std::cout << "\nChoose an option:\n";
        std::cout << "1. Add Record\n";
        std::cout << "2. Fetch Record\n";
        std::cout << "3. Quit\n";
        std::cout << "Enter choice: ";
        std::cin >> choice;

        // Handle user choice with switch-case
        switch (choice) {
            case 1: {  // Add Record
                std::string name;
                int age;
                
                // Get name and age input from the user
                std::cout << "Enter name: ";
                std::cin.ignore();             // Clear input buffer
                std::getline(std::cin, name);  // Read full name as string
                std::cout << "Enter age: ";
                std::cin >> age;

                // Call AddRecord function to add the new record
                AddRecord(name, age);
                break;
            }
            case 2: {  // Fetch Record
                int userID;
                
                // Get the user ID to fetch
                std::cout << "Enter User ID to fetch: ";
                std::cin >> userID;

                // Call FetchRecord function with the user ID
                FetchRecord(userID);
                break;
            }
            case 3:  // Quit
                running = false;  // End the loop and exit program
                std::cout << "Exiting program...\n";
                break;
            default:  // Handle invalid input
                std::cout << "Invalid choice, please try again.\n";
                break;
        }
    }

    return 0;
}
