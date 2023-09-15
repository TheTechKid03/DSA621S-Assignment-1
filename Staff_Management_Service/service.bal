//Ballerina packages that are imported
import ballerina/http;


//Information about the Course
public type Course_Details record {
    readonly string Course_code;
    string Course_name;
    string NQF_level;
};

//Information of the Lecturer
public type Lecturers record {
    readonly int Staff_number;
    Title Title;
    string Name;
    int Age;
    Sex Gender;
    Faculty Faculty;
    string Office_number;
    Courses_taught Courses_taught;
    string Email;
};


//Enums are used to store the data that is already known
public enum Courses_taught{
    Software_Development,
    System_Administration,
    Cyber_Security,
    Communication_Networks
}
public enum Sex{
Male,
Female,
Other

}
public enum Title{

Ms,
Mr,
Mrs

};
public enum Faculty{

Faculty_of_Computing_and_Informatics

}

//Table to store Course Details
table<Course_Details> key(Course_code) CourseTable = table [ ];

//Table to store Lecturer Details
table<Lecturers> key(Staff_number) LectureTable = table [
{Staff_number: 100, Title: "Mr", Name: "Stevovo", 
Age: 39, Gender: "Male", Faculty: "Faculty_of_Computing_and_Informatics",Office_number: "0A1",
Courses_taught: "Communication_Networks", Email: "stjitaro@nust.na"}
 ];


# A service representing a network-accessible API
# bound to port `9090`.
service /Faculty_of_Computing_and_Informatics on new http:Listener(9090) {

    //Retrieve a list of all lecturers within the faculty - GET
    resource function get allLectureres() returns Lecturers[] {
        return LectureTable.toArray();
     }


     
}
        

