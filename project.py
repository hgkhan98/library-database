import tkinter as tk
from tkinter import ttk
import pymysql


class LibraryApp:
    def __init__(self, root, username, password):
        self.root = root
        self.root.geometry("800x600")
        self.root.title("Library Management System")

        # Database Connection
        self.connection = pymysql.connect(
            host='localhost',
            user=username,
            password=password,
            database='library'
        )

        # User Authentication
        self.username_label = tk.Label(root, text="Username:")
        self.username_entry = tk.Entry(root)
        self.password_label = tk.Label(root, text="Password:")
        self.password_entry = tk.Entry(root, show="*")
        self.login_button = tk.Button(root, text="Login", command=self.authenticate_user)
        self.result_label = tk.Label(root, text="")
        self.member_id = None
        self.update_address_window = None
        self.add_book_window = None
        self.employee_window = None
        self.branch_member_window = None
        self.fee_balance_label = None
        # Result Label
        self.result_label = tk.Label(self.root, text="")
        self.result_label.pack()

        # Frame for Available Books Interface
        self.available_books_frame = tk.Frame(self.root)
        # Entry widget for book name input
        self.book_name_entry = tk.Entry(self.available_books_frame)
        self.book_name_entry.pack()
        # Available Books Listbox
        self.available_books_listbox = tk.Listbox(self.available_books_frame)
        self.available_books_listbox.pack()
        # Button to trigger the retrieval
        retrieve_button = tk.Button(self.available_books_frame, text="Retrieve Available Copies",
                                    command=self.retrieve_available_copies)
        retrieve_button.pack()
        # Create a Checkout button
        checkout_button = tk.Button(self.available_books_frame, text="Checkout",
                                    command=self.checkout_selected_book)
        checkout_button.pack(pady=5)

        self.username_label.pack(pady=5)
        self.username_entry.pack(pady=5)
        self.password_label.pack(pady=5)
        self.password_entry.pack(pady=5)
        self.login_button.pack(pady=10)
        self.result_label.pack(pady=10)

    def authenticate_user(self):
        username = self.username_entry.get()
        password = self.password_entry.get()

        # Check user type and validate credentials
        user_type, member_id = self.get_user_type(username, password)

        if user_type is None:
            self.result_label.config(text="Invalid login. Try again.")
        elif user_type == "employee":
            self.result_label.config(text="")  # Clear the error message
            self.show_employee_interface(username)
        elif user_type == "branch_member":
            # Store the member_id for later use
            self.member_id = member_id
            self.result_label.config(text="")  # Clear the error message
            self.show_branch_member_interface(username)

    def get_user_type(self, username, password):
        try:
            with self.connection.cursor() as cursor:
                # Check if the username and password match an employee
                cursor.execute("SELECT staff_id FROM employee WHERE username=%s AND passwords=%s", (username, password))
                if cursor.fetchone():
                    return "employee", None

                # Check if the username and password match a branch member
                cursor.execute("SELECT member_id FROM branch_member WHERE username=%s AND passwords=%s",
                               (username, password))
                member_result = cursor.fetchone()
                if member_result:
                    return "branch_member", member_result[0]

                # No matching user found
                return None, None
        except pymysql.Error as e:
            print(f"Error: {e}")
            return None, None

    def show_employee_interface(self, username):
        self.clear_authentication_fields()

        # Employee Interface
        self.add_book_button = tk.Button(self.root, text="Add Book", command=self.show_add_book_interface)
        self.add_book_button.pack(pady=10)

        # Add Book Copy button
        add_book_copy_button = tk.Button(self.root, text="Add Book Copy", command=self.show_add_book_copy_interface)
        add_book_copy_button.pack(pady=10)

        # View Member's Fee Balance button
        view_fee_balance_button = tk.Button(self.root, text="View Member's Fee Balance",
                                            command=self.show_view_fee_balance_interface)
        view_fee_balance_button.pack(pady=10)

        # Update Book Copy's Condition button
        update_book_copy_condition_button = tk.Button(self.root, text="Update Book Copy's Condition",
                                                      command=self.show_update_book_copy_condition_interface)
        update_book_copy_condition_button.pack(pady=10)

        # Delete Member Account button
        delete_member_account_button = tk.Button(self.root, text="Delete Member Account",
                                                 command=self.show_delete_member_account_interface)
        delete_member_account_button.pack(pady=10)

        # Delete Book Copy button
        delete_book_copy_button = tk.Button(self.root, text="Delete Book Copy",
                                            command=self.show_delete_book_copy_interface)
        delete_book_copy_button.pack(pady=10)

        # Log Out button for the employee interface
        log_out_button = tk.Button(self.root, text="Log Out", command=self.log_out)
        log_out_button.pack(pady=10)

    def show_branch_member_interface(self, username):
        self.clear_authentication_fields()

        # Branch Member Interface
        self.view_available_book_copies_button = tk.Button(
            self.root,
            text="Checkout Books",
            command=self.show_available_book_copies_interface
        )
        self.view_available_book_copies_button.pack(pady=10)

        self.update_address_button = tk.Button(self.root, text="Update Home Address",
                                               command=self.show_update_address_interface)
        self.update_address_button.pack(pady=10)

        self.pay_fines_button = tk.Button(
            self.root,
            text="Pay Fines",
            command=self.show_pay_fines_interface
        )
        self.pay_fines_button.pack(pady=10)

        # Log Out button for the branch member interface
        log_out_button = tk.Button(self.root, text="Log Out", command=self.log_out)
        log_out_button.pack(pady=10)

    def log_out(self):
        # Destroy the current root window
        self.root.destroy()

        # Reinitialize the Tkinter root
        root = tk.Tk()
        LibraryApp(root, username, password)
        root.mainloop()

    def show_login_interface(self):
        # Restore the login interface components
        self.username_label.pack()
        self.username_entry.pack()
        self.password_label.pack()
        self.password_entry.pack()
        self.login_button.pack()
        self.result_label.pack()

        # Pack the Available Books Frame (hide it initially)
        self.available_books_frame.pack_forget()

    def clear_authentication_fields(self):
        self.username_label.pack_forget()
        self.username_entry.pack_forget()
        self.password_label.pack_forget()
        self.password_entry.pack_forget()
        self.login_button.pack_forget()

    def show_add_book_interface(self):
        # Create a new window for adding a book
        self.add_book_window = tk.Toplevel(self.root)
        self.add_book_window.title("Add Book")

        # Fields for adding a new book
        isbn_label = tk.Label(self.add_book_window, text="ISBN:")
        isbn_entry = tk.Entry(self.add_book_window)
        title_label = tk.Label(self.add_book_window, text="Title:")
        title_entry = tk.Entry(self.add_book_window)
        author_name_label = tk.Label(self.add_book_window, text="Author Name:")
        author_name_entry = tk.Entry(self.add_book_window)
        author_dob_label = tk.Label(self.add_book_window, text="Author Date of Birth:")
        author_dob_entry = tk.Entry(self.add_book_window)
        publisher_name_label = tk.Label(self.add_book_window, text="Publisher Name:")
        publisher_name_entry = tk.Entry(self.add_book_window)
        genre_type_label = tk.Label(self.add_book_window, text="Genre Type:")
        genre_type_entry = tk.Entry(self.add_book_window)
        publication_date_label = tk.Label(self.add_book_window, text="Publication Date:")
        publication_date_entry = tk.Entry(self.add_book_window)
        language_label = tk.Label(self.add_book_window, text="Language:")
        language_entry = tk.Entry(self.add_book_window)
        format_label = tk.Label(self.add_book_window, text="Format:")
        format_entry = tk.Entry(self.add_book_window)

        add_button = tk.Button(
            self.add_book_window,
            text="Add Book",
            command=lambda: self.add_book(
                isbn_entry.get(),
                title_entry.get(),
                author_name_entry.get(),
                author_dob_entry.get(),
                publisher_name_entry.get(),
                genre_type_entry.get(),
                publication_date_entry.get(),
                language_entry.get(),
                format_entry.get()
            )
        )

        # Pack the widgets
        isbn_label.pack(pady=5)
        isbn_entry.pack(pady=5)
        title_label.pack(pady=5)
        title_entry.pack(pady=5)
        author_name_label.pack(pady=5)
        author_name_entry.pack(pady=5)
        author_dob_label.pack(pady=5)
        author_dob_entry.pack(pady=5)
        publisher_name_label.pack(pady=5)
        publisher_name_entry.pack(pady=5)
        genre_type_label.pack(pady=5)
        genre_type_entry.pack(pady=5)
        publication_date_label.pack(pady=5)
        publication_date_entry.pack(pady=5)
        language_label.pack(pady=5)
        language_entry.pack(pady=5)
        format_label.pack(pady=5)
        format_entry.pack(pady=5)

        add_button.pack(pady=10)

    def add_book(self, isbn, title, author_name, author_dob, publisher_name, genre_type, publication_date, language,
                 format):
        try:
            with self.connection.cursor() as cursor:
                # Call the add_book procedure in the database
                cursor.callproc('add_book', (
                isbn, title, author_name, author_dob, publisher_name, genre_type, publication_date, language, format))
                self.connection.commit()

                self.result_label.config(text="Book added successfully.")
        except pymysql.Error as e:
            print(f"Error: {e}")
            self.result_label.config(text="Error adding book.")
        finally:
            # Close the window after operation
            if self.add_book_window:
                self.add_book_window.destroy()

    def show_add_book_copy_interface(self):
        # Create a new window for adding a book copy
        self.add_book_copy_window = tk.Toplevel(self.root)
        self.add_book_copy_window.title("Add Book Copy")

        # Fields for adding a new book copy
        isbn_label = tk.Label(self.add_book_copy_window, text="ISBN:")
        isbn_entry = tk.Entry(self.add_book_copy_window)
        book_condition_label = tk.Label(self.add_book_copy_window, text="Book Condition:")
        book_condition_entry = tk.Entry(self.add_book_copy_window)
        date_of_acquisition_label = tk.Label(self.add_book_copy_window, text="Date of Acquisition:")
        date_of_acquisition_entry = tk.Entry(self.add_book_copy_window)
        branch_id_label = tk.Label(self.add_book_copy_window, text="Branch ID:")
        branch_id_entry = tk.Entry(self.add_book_copy_window)

        add_button = tk.Button(
            self.add_book_copy_window,
            text="Add Book Copy",
            command=lambda: self.add_book_copy(
                isbn_entry.get(),
                book_condition_entry.get(),
                date_of_acquisition_entry.get(),
                branch_id_entry.get()
            )
        )

        # Pack the widgets
        isbn_label.pack(pady=5)
        isbn_entry.pack(pady=5)
        book_condition_label.pack(pady=5)
        book_condition_entry.pack(pady=5)
        date_of_acquisition_label.pack(pady=5)
        date_of_acquisition_entry.pack(pady=5)
        branch_id_label.pack(pady=5)
        branch_id_entry.pack(pady=5)

        add_button.pack(pady=10)

    def add_book_copy(self, isbn, book_condition, date_of_acquisition, branch_id):
        try:
            with self.connection.cursor() as cursor:
                # Call the add_book_copy procedure in the database
                cursor.callproc('add_book_copy', (isbn, book_condition, date_of_acquisition, branch_id))
                self.connection.commit()

                self.result_label.config(text="Book copy added successfully.")
        except pymysql.Error as e:
            print(f"Error: {e}")
            self.result_label.config(text="Error adding book copy.")
        finally:
            # Close the window after operation
            if self.add_book_copy_window:
                self.add_book_copy_window.destroy()

    def show_view_fee_balance_interface(self):
        # Create a new window for viewing member's fee balance
        self.view_fee_balance_window = tk.Toplevel(self.root)
        self.view_fee_balance_window.title("View Member's Fee Balance")

        # Fields for viewing fee balance
        username_label = tk.Label(self.view_fee_balance_window, text="Username:")
        username_entry = tk.Entry(self.view_fee_balance_window)
        view_button = tk.Button(
            self.view_fee_balance_window,
            text="View Fee Balance",
            command=lambda: self.view_fee_balance(username_entry.get())
        )
        self.fee_balance_label = tk.Label(self.view_fee_balance_window, text="Fee Balance:")

        # Pack the widgets
        username_label.pack(pady=5)
        username_entry.pack(pady=5)
        view_button.pack(pady=10)
        self.fee_balance_label.pack(pady=5)

    def view_fee_balance(self, username):
        try:
            with self.connection.cursor() as cursor:
                # Get member_id based on the entered username
                cursor.execute("SELECT member_id FROM branch_member WHERE username=%s", (username,))
                member_result = cursor.fetchone()

                if member_result:
                    member_id = member_result[0]
                    # Call the get_fee_balance function in the database
                    cursor.execute('SELECT get_fee_balance(%s) AS fee_balance', (member_id,))
                    fee_result = cursor.fetchone()

                    if fee_result:
                        fee_balance = fee_result[0]  # Access the element using integer index
                        self.fee_balance_label.config(text=f"Fee Balance: {fee_balance}")
                    else:
                        self.fee_balance_label.config(text="Fee balance not available.")
                else:
                    self.fee_balance_label.config(text="Member not found.")
        except pymysql.Error as e:
            print(f"Error: {e}")
            self.fee_balance_label.config(text="Error retrieving fee balance.")

    def show_update_book_copy_condition_interface(self):
        # Create a new window for updating book copy condition
        self.update_book_copy_condition_window = tk.Toplevel(self.root)
        self.update_book_copy_condition_window.title("Update Book Copy Condition")

        # Fields for updating book copy condition
        isbn_label = tk.Label(self.update_book_copy_condition_window, text="ISBN:")
        isbn_entry = tk.Entry(self.update_book_copy_condition_window)
        copy_number_label = tk.Label(self.update_book_copy_condition_window, text="Copy Number:")
        copy_number_entry = tk.Entry(self.update_book_copy_condition_window)
        book_condition_label = tk.Label(self.update_book_copy_condition_window, text="New Book Condition:")
        book_condition_entry = tk.Entry(self.update_book_copy_condition_window)

        update_button = tk.Button(
            self.update_book_copy_condition_window,
            text="Update Book Copy Condition",
            command=lambda: self.update_book_copy_condition(
                isbn_entry.get(),
                copy_number_entry.get(),
                book_condition_entry.get()
            )
        )

        # Label to display update message
        self.update_condition_result_label = tk.Label(self.update_book_copy_condition_window, text="")

        # Pack the widgets
        isbn_label.pack(pady=5)
        isbn_entry.pack(pady=5)
        copy_number_label.pack(pady=5)
        copy_number_entry.pack(pady=5)
        book_condition_label.pack(pady=5)
        book_condition_entry.pack(pady=5)

        update_button.pack(pady=10)
        self.update_condition_result_label.pack(pady=10)

    def update_book_copy_condition(self, isbn, copy_number, new_condition):
        try:
            with self.connection.cursor() as cursor:
                # Call the update_book_copy_condition procedure in the database
                cursor.callproc('update_book_copy_condition', (isbn, copy_number, new_condition))
                self.connection.commit()

                self.update_condition_result_label.config(text="Book copy condition updated successfully.")
        except pymysql.Error as e:
            print(f"Error: {e}")
            self.update_condition_result_label.config(text=e.args[1])

    def show_delete_member_account_interface(self):
        # Create a new window for deleting a member account
        self.delete_member_account_window = tk.Toplevel(self.root)
        self.delete_member_account_window.title("Delete Member Account")

        # Fields for deleting a member account
        username_label = tk.Label(self.delete_member_account_window, text="Username:")
        username_entry = tk.Entry(self.delete_member_account_window)

        delete_button = tk.Button(
            self.delete_member_account_window,
            text="Delete Member Account",
            command=lambda: self.delete_member_account(username_entry.get())
        )

        # Label to display delete message and MySQL error message
        self.delete_member_result_label = tk.Label(self.delete_member_account_window, text="")

        # Pack the widgets
        username_label.pack(pady=5)
        username_entry.pack(pady=5)
        delete_button.pack(pady=10)
        self.delete_member_result_label.pack(pady=10)

    def delete_member_account(self, username):
        try:
            with self.connection.cursor() as cursor:
                # Get member_id based on the entered username
                cursor.execute("SELECT member_id FROM branch_member WHERE username=%s", (username,))
                member_result = cursor.fetchone()

                if member_result:
                    member_id = member_result[0]
                    # Call the delete_member procedure in the database
                    cursor.callproc('delete_member', (member_id,))
                    self.connection.commit()

                    self.delete_member_result_label.config(text="Member account deleted successfully.")
                else:
                    self.delete_member_result_label.config(text="Member not found.")
        except pymysql.Error as e:
            print(f"Error: {e}")
            self.delete_member_result_label.config(text=e.args[1])

    def show_delete_book_copy_interface(self):
        # Create a new window for deleting a book copy
        self.delete_book_copy_window = tk.Toplevel(self.root)
        self.delete_book_copy_window.title("Delete Book Copy")

        # Fields for deleting a book copy
        isbn_label = tk.Label(self.delete_book_copy_window, text="ISBN:")
        isbn_entry = tk.Entry(self.delete_book_copy_window)
        copy_number_label = tk.Label(self.delete_book_copy_window, text="Copy Number:")
        copy_number_entry = tk.Entry(self.delete_book_copy_window)

        # Result label to display messages
        self.result_label = tk.Label(self.delete_book_copy_window, text="")

        delete_button = tk.Button(
            self.delete_book_copy_window,
            text="Delete Book Copy",
            command=lambda: self.delete_book_copy(copy_number_entry.get(), isbn_entry.get())
        )

        # Pack the widgets
        isbn_label.pack(pady=5)
        isbn_entry.pack(pady=5)
        copy_number_label.pack(pady=5)
        copy_number_entry.pack(pady=5)

        delete_button.pack(pady=10)
        self.result_label.pack(pady=10)

    def delete_book_copy(self, copy_number, isbn):
        try:
            with self.connection.cursor() as cursor:
                # Call the delete_book_copy procedure in the database
                cursor.callproc('delete_book_copy', (copy_number, isbn))
                self.connection.commit()

                # Display the result message in the result_label
                self.result_label.config(text="Book copy deleted successfully.")

        except pymysql.Error as e:
            print(f"Error: {e}")
            # Display the error message in the result_label
            self.result_label.config(text=e.args[1])

    def show_available_book_copies_interface(self):
        # Create a new Toplevel window
        available_books_window = tk.Toplevel(self.root)
        available_books_window.title("Available Book Copies")

        # Fields for book name input
        book_name_label = tk.Label(available_books_window, text="Book Name:")
        book_name_entry = tk.Entry(available_books_window)

        # Create a Listbox to display available book copies
        available_books_listbox = tk.Listbox(available_books_window)

        # Create the result label
        self.result_label = tk.Label(available_books_window, text="")
        self.result_label.pack(pady=10)  # Add some padding

        # Create a button to trigger the retrieval and bind it to checkout_selected_book
        retrieve_button = tk.Button(
            available_books_window,
            text="Retrieve Available Copies",
            command=lambda: self.retrieve_available_copies(book_name_entry.get(), available_books_listbox)
        )

        # Create a Checkout button
        checkout_button = tk.Button(
            available_books_window,
            text="Checkout",
            command=lambda: self.checkout_selected_book(available_books_listbox)
        )

        # Pack the widgets
        book_name_label.pack(pady=5)
        book_name_entry.pack(pady=5)
        retrieve_button.pack(pady=5)
        available_books_listbox.pack(padx=10, pady=5, fill=tk.X, expand=True)
        checkout_button.pack(pady=5)

    def retrieve_available_copies(self, book_name, available_books_listbox):
        # Clear previous results from the listbox
        available_books_listbox.delete(0, tk.END)

        try:
            with self.connection.cursor() as cursor:
                # Call the get_available_book_copies procedure
                cursor.execute('CALL get_available_book_copies(%s)', (book_name,))
                result = cursor.fetchall()

                # Display the results in the listbox and store data
                for row in result:
                    display_text = f"Copy Number: {row[0]}, " \
                                   f"Condition: {row[1]}, " \
                                   f"Title: {row[2]}, " \
                                   f"Author: {row[3]}, " \
                                   f"ISBN: {row[4]}, " \
                                   f"Language: {row[5]}, " \
                                   f"Format: {row[6]}"
                    available_books_listbox.insert(tk.END, display_text)

        except pymysql.Error as e:
            print(f"Error: {e}")
            self.result_label.config(text="Error fetching available book copies.")

    def checkout_selected_book(self, listbox):
        # Get the selected item from the Listbox
        selected_index = listbox.curselection()

        if selected_index:
            try:
                selected_item = listbox.get(selected_index[0])

                with self.connection.cursor() as cursor:
                    # Check branch_member's account_state
                    cursor.execute('SELECT account_state FROM branch_member WHERE member_id = %s', (self.member_id,))
                    account_state_result = cursor.fetchone()

                    if account_state_result and account_state_result[0] == 'Valid':
                        # Extract ISBN and copy number from the selected item
                        isbn = selected_item.split(", ")[4].split(": ")[1]
                        copy_number = selected_item.split(", ")[0].split(": ")[1]

                        # Allow checkout by calling the checkout_book_copy procedure
                        cursor.callproc('checkout_book_copy', (isbn, copy_number, self.member_id))
                        self.connection.commit()
                        title = selected_item.split(", ")[2].split(": ")[1]
                        # Retrieve the due date
                        query = 'SELECT due_date FROM book_copy WHERE isbn = %s AND copy_number = %s'
                        cursor.execute(query, (isbn, copy_number))
                        result = cursor.fetchone()
                        due_date = result[0]

                        self.result_label.config(text=f"'{title}' successfully checked out. Due date: {due_date}")
                        # Clear the listbox after a successful checkout
                        listbox.delete(0, tk.END)
                    elif account_state_result and account_state_result[0] == 'Invalid':
                        self.result_label.config(text="User not eligible for checkout: Fine balance above $10.")
                    else:
                        self.result_label.config(text="Error checking account state.")
            except pymysql.Error as e:
                print(f"Error: {e}")
                self.result_label.config(text="Error during checkout.")
        else:
            self.result_label.config(text="No book selected for checkout.")
    
    def show_update_address_interface(self):
        # Create a new window for updating home address
        self.update_address_window = tk.Toplevel(self.root)
        self.update_address_window.title("Update Home Address")

        # Fields for updating home address
        street_number_label = tk.Label(self.update_address_window, text="Street Number:")
        street_number_entry = tk.Entry(self.update_address_window)
        street_name_label = tk.Label(self.update_address_window, text="Street Name:")
        street_name_entry = tk.Entry(self.update_address_window)
        city_label = tk.Label(self.update_address_window, text="City:")
        city_entry = tk.Entry(self.update_address_window)
        state_label = tk.Label(self.update_address_window, text="State:")
        state_entry = tk.Entry(self.update_address_window)
        zip_code_label = tk.Label(self.update_address_window, text="ZIP Code:")
        zip_code_entry = tk.Entry(self.update_address_window)

        # Result label to display messages
        self.result_label = tk.Label(self.update_address_window, text="")

        update_button = tk.Button(
            self.update_address_window,
            text="Update Address",
            command=lambda: self.update_member_address(
                self.member_id,
                street_number_entry.get(),
                street_name_entry.get(),
                city_entry.get(),
                state_entry.get(),
                zip_code_entry.get()
            )
        )

        # Pack the widgets
        street_number_label.pack(pady=5)
        street_number_entry.pack(pady=5)
        street_name_label.pack(pady=5)
        street_name_entry.pack(pady=5)
        city_label.pack(pady=5)
        city_entry.pack(pady=5)
        state_label.pack(pady=5)
        state_entry.pack(pady=5)
        zip_code_label.pack(pady=5)
        zip_code_entry.pack(pady=5)

        update_button.pack(pady=10)
        self.result_label.pack(pady=10)

    def update_member_address(self, member_id, street_number, street_name, city, state, zip_code):
        try:
            with self.connection.cursor() as cursor:
                # Call the update_member_address procedure in the database
                cursor.callproc('update_member_address', (member_id, street_number, street_name, city, state, zip_code))
                self.connection.commit()

                # Display the result message in the result_label
                self.result_label.config(text="Address updated successfully.")

        except pymysql.Error as e:
            print(f"Error: {e}")
            # Display the error message in the result_label
            self.result_label.config(text=e.args[1])

    def show_pay_fines_interface(self):
        # Create a new window for paying fines
        self.pay_fines_window = tk.Toplevel(self.root)
        self.pay_fines_window.title("Pay Fines")

        # Fields for paying fines
        amount_label = tk.Label(self.pay_fines_window, text="Amount:")
        amount_entry = tk.Entry(self.pay_fines_window)

        pay_button = tk.Button(
            self.pay_fines_window,
            text="Pay",
            command=lambda: self.pay_fines(amount_entry.get(), self.pay_fines_window)
        )

        # Label for displaying messages
        self.pay_fines_message_label = tk.Label(self.pay_fines_window, text="")

        # Pack the widgets
        amount_label.pack(pady=5)
        amount_entry.pack(pady=5)
        pay_button.pack(pady=10)
        self.pay_fines_message_label.pack(pady=5)

    def pay_fines(self, amount, window):
        try:
            with self.connection.cursor() as cursor:
                # Call the update_fee_balance procedure in the database
                cursor.callproc('update_fee_balance', (self.member_id, amount))
                self.connection.commit()

                # Display the current fee balance
                cursor.execute("SELECT fee_balance FROM branch_member WHERE member_id=%s", (self.member_id,))
                fee_balance_result = cursor.fetchone()

                if fee_balance_result:
                    fee_balance = fee_balance_result[0]
                    self.pay_fines_message_label.config(text=f"Fee Balance Updated. Current Fee Balance: {fee_balance}")
                else:
                    self.pay_fines_message_label.config(text="Error fetching fee balance.")
        except pymysql.Error as e:
            print(f"Error: {e}")
            self.pay_fines_message_label.config(text=e.args[1])

if __name__ == "__main__":
    # Get username and password from the user in the terminal
    username = input("Enter mySQL server username: ")
    password = input("Enter mySQL server password: ")

    root = tk.Tk()
    app = LibraryApp(root, username, password)
    root.mainloop()
