 import ballerina/io;


// Creates a gRPC client to interact with the remote server.
ManagementClient ep = check new ("http://localhost:9090");
 

public function main() returns error? {

io:println(MainMenu());
    
    
}



function MainMenu() returns string|error {
    io:println("1) Login");
   
   
    string input =io:readln("Please enter 1 to log in: ");

    if (input == "1") {
        return Login();
    }

    else {
        return Register();
    }


    
}

function Register() returns string|error {

    string UserId = io:readln("Enter User ID...");
    string Name = io:readln("Enter User Name...");
    string profile = io:readln("Enter Profile...");

    User theUser = {
        userId: UserId,
        name: Name,
        accountType: profile
    };

    string addedUser = check ep->createUser(theUser);

    io:println(addedUser);

    string input = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }

    return addedUser;

}

function Login() returns string|error {


    io:println("-----Welcome to the Library-----");

    io:println("\n\n1)Librarian");
    io:println("2)Student");




    string input = io:readln("\n\nEnter user type: ");

   // User user = check ep->getUser(id);

    if (input == "1") {
          return Menu();
    }

    else {
        return studentMenu();
      
    }

}

function studentMenu() returns string|error {

    io:println("1) Get Available Books");
    io:println("2) Locate Book by ISBN");
    io:println("3) Borrow a Book");

    string input = io:readln("please select a Number: ");

    if (input == "1") {

        string|error result = availableBook();

        return result;

    }

    if (input == "2") {

        string|error result = LocateBookByISBN();

        return result;

    }

    if (input == "3") {

        string|error result = borrowedBook();

        return result;

    }

    string inputx = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }

    return "Thank you for using the library";


}

function Menu() returns string|error {
   
   io:println("1) Add a User");
   io:println("2) Add a Book:  ");
   io:println("3) Update a Book: ");
   io:println("4) Remove a Book: ");
   io:println("5) Get Available Books: ");
   

  string input = io:readln("please choose a number: ");

  if(input=="1") {

   string|error user = createUser();

   return user;

  }

 if(input=="2") {

   string|error book = addBook();

   return book;
  }

 if(input=="3") {

   string|error result = updateBook();

   return "updated";

  }

  if(input=="4") {

   string|error result = removeBook();

   return result;

  }

    if(input == "5")    {

        string|error result = availableBook();

        return result;

    }

    return "That selection isn't available";

}

function addBook() returns string|error{

        string Title = io:readln( "Enter Book Title: ");
        string Author = io:readln("Enter Authors Name: ");
        string Location = io:readln("Enter the Book's location in the library: ");
        string ISBN = io:readln("Enter the Book's isbn number: ");
        string Status = io:readln("Is the book available? ");

         Book book = {
                  title: Title,
                  author_1: Author,
                  author_2: "",
                  location: Location,
                  isbn: ISBN,
                  status: Status
    
                };

        string addedBook = check ep->addBook(book);
        io:println(addedBook);

    string input = io:readln("\n\nEnter (1) to return to Exit ");

    if input == "1" {
        return Menu();
    }
        return addedBook;

}


function createUser() returns string|error {

string UserId = io:readln("Enter User ID...");
string Name = io:readln("Enter User Name...");
string  profile= io:readln("Enter Profile...");

User theUser = {
                  userId :  UserId,
                  name : Name,
                  accountType: profile
    };

        string addedUser = check ep->createUser(theUser);
        io:println(addedUser);

        string input=io:readln("\n\nEnter (1) to return to Exit ");

        if input == "1" {
          return Menu();
        }

        return addedUser;

    }

function updateBook() returns string|error{

        string ISBN = io:readln("Enter the Book's isbn number: ");
        
        string Title = io:readln("Enter Book Title: ");
        string Author = io:readln("Enter Authors Name...");
        string Location = io:readln("Enter the Book's location in the library: ");
        
        string Status = io:readln("Is the book available? ");

         Book book = {
                  title: Title,
                  author_1: Author,
                  author_2: "",
                  location: Location,
                  isbn: ISBN,
                  status: Status
    
                };

        Book updatedBook = check ep->updateBook(book);

        string theUpdate = updatedBook.toString();

    string input = io:readln("\n\nEnter (1) to return to Exit ");

    if input == "1" {
        return Menu();
    }
    

        return theUpdate;

}

function removeBook() returns string|error {

    string isbn = io:readln("Enter The Books ISBN: ");

string removed= check ep->removeBook(isbn);

io:print(removed);

    string input = io:readln("\n\nEnter (1) to return to Exit ");

    if input == "1" {
        return Menu();
    }
    

    return removed;


}

function availableBook() returns string|error {

        
string books = check ep->availableBooks();

    io:println(books);

    string input = io:readln("\n\nEnter (1) to return to Exit ");

    if input == "1" {
        return Login();
    }
    
    return books;


}

function LocateBookByISBN() returns string|error {

string  isbn = io:readln("Enter The Books ISBN:");

string theBook = check ep->locateBook(isbn);

io:println( theBook);

    string input = io:readln("\n\nEnter (1) to return to Exit ");

    if input == "1" {
        return Login();
    }

return theBook;

}


function borrowedBook()returns string|error {


  io:println("Borrow a Book");


string UserId  = io:readln("Enter the User ID: ");
string ISBN = io:readln("Enter  the  Books ISBN: ");

    Borrowed_books borrowed = {
        userId: UserId,
        isbn: ISBN
    };

    Book book = {
        title: "",
        author_1: "",
        author_2: "",
        location: "",
        isbn: ISBN,
        status: "Borrowed"
    };

    // Executes a simple remote call.
    
    string|error borrowedBook = check ep->borrowBook(borrowed);
    Book|error updateStatus = check ep->updateBook(book);


    io:println(borrowedBook);

    string input = io:readln("\n\nEnter (1) to return to Exit ");

    if input == "1" {
        return Login();
    }
    
    return borrowedBook;


}
