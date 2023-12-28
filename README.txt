This README provides instructions for running our Library Management System application using the Tkinter library in Python. The system allows you to manage various library operations, including user authentication, book management, employee tasks, and branch member activities.

Table of Contents:
Prerequisites
Running the Application
User Authentication
Features
Branch Member Interface
Employee Interface
Usage Instructions
Troubleshooting 
Acknowledgments

Prerequisites:
Before running the application, ensure the following are installed on your computer:
Python (version 3.x)
Tkinter (available with the Python standard library)
MySQL Server

Running the Application:
Launch the Application:
Run the Library Management System application.
Ensure that you have Python (version 3.x) installed on your computer.
You will be prompted to provide your mySQL server username and password. The default username for most users is "root".

Access Database Information:
Run the entire provided database dump.
Navigate to the schema window and click on the table icon next to the "branch_member" and "employee" tables.
Reference the 'username' and 'passwords' columns for the next step.

Enter Credentials:
You will be presented with a login screen upon launching the application.
Input your credentials in the provided fields:
Username: Enter your username.
Password: Enter your password.
Click "Login":
After entering your credentials, click the "Login" button to proceed.

User Authentication:
The application will authenticate your credentials and determine your user type (employee or branch member).
If the credentials are invalid, an error message will be displayed.

Accessing Employee Interface:
If you are an employee, the application will grant you access to the Employee Interface.
You can perform various employee operations such as adding books, viewing member fee balances, and more.

Accessing Branch Member Interface:
If you are a branch member, the application will grant you access to the Branch Member Interface.
You can perform activities like checking out books, updating your home address, and paying fines.
Log Out:
To exit the application, click the "Log out" button.

Note: If you encounter any issues during login, double-check your username and password.

Features:

Branch Member Interface:

Checkout Books:
Description: View and checkout available book copies.
Usage: Navigate to the Branch Member Interface and click on the "Checkout Books" button. Enter the book name (case-insensitive) and click "Retrieve Available Copies. If book_copies with the provided title exists, the listbox will be populated with available copies. Please reference the book and book_copy table in the database for valid book titles.  Click "Checkout" for the selected book copy. Only users with "Valid" under the "account_state" column in the "branch_member" table will be able to checkout available book copies.


Update Home Address:
Description: Update the home address associated with the branch member's account.
Usage: Navigate to the Branch Member Interface and click on the "Update Home Address" button. Enter the new address details and click "Update Address."

Pay Fines:
Description: Pay fines associated with the branch member's account.
Usage: Navigate to the Branch Member Interface and click on the "Pay Fines" button. Enter the amount to pay and click "Pay." A user cannot pay an amount that exceeds their "fee_balance" (column in "branch_member" table).

Employee Interface:

Add Book:
Description: Add a new book to the library catalog.
Usage: Navigate to the Employee Interface and click on the "Add Book" button. Enter the book details such as ISBN, title, author, etc., and click "Add Book." Ensure the Publication Date entry is under the "yyyy-mm-dd" format. Users are allowed to enter multiple genres, but please ensure to separate with a comma. Genres that do not exist in the database will not be inserted into the "book_has_genre" table.

Add Book Copy:
Description: Add a new copy of a book to the library inventory.
Usage: Navigate to the Employee Interface and click on the "Add Book Copy" button. Enter the book details and copy-specific information, and click "Add Book Copy." An error will be produced and the operation will not be performed if Branch ID or ISBN inputs do not currently exist in the database or if the Book Condition input for a non-audiobook is not 'Poor', 'Fair', 'Good', or 'Excellent'.

View Member's Fee Balance:
Description: Check the fee balance of a library member.
Usage: Navigate to the Employee Interface and click on the "View Member's Fee Balance" button. Enter the member's username, and click "View Fee Balance."

Update Book Copy's Condition:
Description: Modify the condition of a book copy.
Usage: Navigate to the Employee Interface and click on the "Update Book Copy's Condition" button. Enter the book's ISBN, copy number, and the new condition, and click "Update Book Copy Condition." The new condition is limited to the following terms:  'Poor', 'Fair', 'Good', and 'Excellent'. A user can only downgrade a book's condition, upgrades are not permitted. Only non-audiobooks' conditions can be modified. If an audiobook in inserted or an upgrade is attempted, an error will be produced and the operation will not be performed.

Delete Member Account:
Description: Delete a branch member's account.
Usage: Navigate to the Employee Interface and click on the "Delete Member Account" button. Enter the member's username and click "Delete Member Account." Users cannot delete a member with a non-zero fee balance or members with checked out book copies. If either case is attempted, an error will be produced and the operation will not be performed. 

Delete Book Copy:
Description: Remove a book copy from the inventory.
Usage: Navigate to the Employee Interface and click on the "Delete Book Copy" button. Enter the book's ISBN and copy number, and click "Delete Book Copy." If users attempt to delete a book copy that is currently checked out to a member an error will be produced.

Usage Instructions:
Depending on your user type (employee or library member), you will have different access to features.
Follow the on-screen instructions to navigate through the application.

Troubleshooting:
If you encounter any issues during login, double-check your username and password.

Acknowledgments:
Special thanks to Hibah Khan, Sabiha Sarao, and Mohamoud Barre for their contributions.
