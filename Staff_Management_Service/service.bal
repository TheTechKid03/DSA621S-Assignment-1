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
    readonly string Staff_number;
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
enum Courses_taught{
    Software_Development,
    System_Administration,
    Cyber_Security,
    Communication_Networks
}
enum Sex{
Male,
Female,
Other

}
enum Title{

Ms,
Mr,
Mrs

};
enum Faculty{

Faculty_of_Computing_and_Informatics

}


table<Course_Details> key(Course_code) CourseTable = table [ ];


table<Lecturers> key(Staff_number) LectureTable = table [ ];


# A service representing a network-accessible API
# bound to port `9090`.
service /Faculty_of_Computing_and_Informatics on new http:Listener(9090) {

    resource function post newLectureres(Lecturers newLecturer) returns string {
        error? AddNewLecturer = LectureTable.add(newLecturer);

    if (AddNewLecturer is error){

        return "Testing" + AddNewLecturer.message();

    }else{

        return  newLecturer.Name + "saved succesfully" ;

    }

        
     }
}
