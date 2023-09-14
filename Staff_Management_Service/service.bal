import ballerina/http;


public type Course_Details record {
    readonly int Course_code;
    string Course_name;
    string NQF_level;
};

enum Courses_taught{
    Comp,
    engine,
    space,
    drinking
}

enum Sex{

Male,
Female

}

enum Title{

Ms,
Mr,
Mrs

};


public type Lecturers record {
    readonly string Staff_number;
    string Staff_name;
    Title Title;
    string Office_number;
    Courses_taught Courses_taught;
    string Email;
    Sex gender;
};


public final table<Course_Details> key(Course_code) CourseTable = table [

];


public final table<Lecturers> key(Staff_number) LectureTable = table [

];


# A service representing a network-accessible API
# bound to port `9090`.
service /Faculty_of_Computing_and_Informatics on new http:Listener(9090) {

    resource function post newLectureres(Lecturers newLecturer) returns string {
        error? AddNewLecturer = LectureTable.add(newLecturer);

    if (AddNewLecturer is error){

        return "Testing" + AddNewLecturer.message();

    }else{

        return  newLecturer.Staff_name + "saved succesfully" ;

    }

        
     }
}
