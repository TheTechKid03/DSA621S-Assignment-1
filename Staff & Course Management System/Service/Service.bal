//Imports Neccesary IO
import ballerina/http;
import ballerina/io;

//Record for Course
type Course readonly & record {
    string Course_code;
    string Name;
    string NQF_level;
};


//Record for Lecturer
public type Lecturers readonly & record {
    string Staff_number;
    string Title;
    string Name;
    string Surname;
    string Age;
    string Gender;
    string Office_number;
    string First_course;
    string Second_course;
    string Third_course;
    string Email;
};


//Tables to hold the data for course and lecturer
table<Course> key(Course_code) Course_Table = table [];
table<Lecturers> key(Staff_number) Lecturer_Table = table [];


//initiating the servide
service /Faculty_of_Computing_and_Informatics on new http:Listener(8080) {

//Resource function to add a course
resource function post addCourse(Course course) returns string {
        io:println(course);
        error? err = Course_Table.add(course);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${course.Name} saved successfully`;
    }

//Resource function to add a lecturer
resource function post addLecturer(Lecturers Lecturer) returns string {
        io:println(Lecturer);
        error? err = Lecturer_Table.add(Lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${Lecturer.Name} saved successfully`;
    }

//Resource function to get all courses
 resource function get getAllCourses() returns Course[] {
        return Course_Table.toArray();
    }

//Resource function to get all lecturers
 resource function get getAllLecturers() returns Lecturers[] {
        return Lecturer_Table.toArray();
    }

//Resource function to update a course
resource function put updateCourse(Course course) returns string {
        io:println(course);
        error? err = Course_Table.put(course);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `Course Code: ${course.Course_code} updated successfully`;
    }

//Resource function to update a lecturer
    resource function put updateLecturer(Lecturers Lecturer) returns string {
        io:println(Lecturer);
        error? err = Lecturer_Table.put(Lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `Staff number: ${Lecturer.Staff_number} updated successfully`;
    }
    
//Resource function to get course by course code
  resource function get getCoursebyCoursecode(string Course_code) returns Course|string {
        foreach Course course in Course_Table {
            if (course.Course_code === Course_code) {
                return course;
            }
        }
        return Course_code + " is invalid";
    }

//Resource function to get lecturer by staff number
    resource function get getLecturerbyStaffnumber(string Staff_number) returns Lecturers|string {
        foreach Lecturers Lecturer in Lecturer_Table {
            if (Lecturer.Staff_number === Staff_number) {
                return Lecturer;
            }
        }
        return Staff_number + " is invalid";
    }

//Resource function to delete course by course code
 resource function delete deleteCourse(Course course) returns string {
        io:println(course);
        Course err = Course_Table.remove(course.Course_code);
        if (err is Course) {
            return "Successfully Deleted: " + course.Course_code;
        } 
    }

//Resource function to delete lectuer by staff number
 resource function delete deleteLecturer(Lecturers Lecturer) returns string {
        io:println(Lecturer);
        Lecturers err = Lecturer_Table.remove(Lecturer.Staff_number);
        if (err is Lecturers) {
            return "Successfully Deleted: " + Lecturer.Staff_number;
        } 
    }

//Resource function to get courses with certain NQF level
resource function get getCoursesbyNQFlevel(string NQF_level) returns table<Course> {
       table <Course> getCoursesbyNQF = from var course in Course_Table
       where course.NQF_level === NQF_level
       select course;
       return getCoursesbyNQF;
        }

//Resource function to get lecturers that teach certain course
resource function get getLecturerbyCourses(string First_course) returns table<Lecturers> {
       table <Lecturers> getLecturerbyCourses = from var Lecturer in Lecturer_Table
       where Lecturer.First_course === First_course
       ||Lecturer.Second_course === First_course
       ||Lecturer.Third_course === First_course
       select Lecturer;
       return getLecturerbyCourses;
        }

//Resource function to get lecturers by office number
resource function get getLecturerbyOffice(string Office_number) returns table<Lecturers> {
       table <Lecturers> getLecturerbyOffice = from var Lecturer in Lecturer_Table
       where Lecturer.Office_number === Office_number
       select Lecturer;
       return getLecturerbyOffice;
        }
}