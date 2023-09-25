import ballerina/http;
import ballerina/io;

// Define a readonly and record type for the Course entity
type Course readonly & record {
    string Course_code;
    string Name;
    string NQF_level;
};

// Define a readonly and record type for the Lecturers entity
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

// Create a table for storing Course records with a unique key on Course_code
table<Course> key(Course_code) Course_table = table [];
// Create a table for storing Lecturer records with a unique key on Staff_number
table<Lecturers> key(Staff_number) Lecturer_Table = table [];

// Create a service named "Faculty_of_Computing_and_Informatics" that listens on port 8080
service /Faculty_of_Computing_and_Informatics on new http:Listener(8080) {

    // Define a resource function to add a new Course record via HTTP POST
    resource function post addCourse(Course course) returns string {
        io:println(course);
        // Attempt to add the course to the Course_table
        error? err = Course_table.add(course);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${course.Name} saved successfully`;
    }

    // Define a resource function to add a new Lecturer record via HTTP POST
    resource function post addLecturer(Lecturers Lecturer) returns string {
        io:println(Lecturer);
        // Attempt to add the lecturer to the Lecturer_Table
        error? err = Lecturer_Table.add(Lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${Lecturer.Name} saved successfully`;
    }

    // Define a resource function to update a Course record via HTTP PUT
    resource function put updateCourse(Course course) returns string {
        io:println(course);
        // Attempt to update the course in the Course_table
        error? err = Course_table.put(course);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `Course code: ${course.Course_code} updated successfully`;
    }

    // Define a resource function to update a Lecturer record via HTTP PUT
    resource function put updateLecturer(Lecturers Lecturer) returns string {
        io:println(Lecturer);
        // Attempt to update the lecturer in the Lecturer_Table
        error? err = Lecturer_Table.put(Lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `Staff number: ${Lecturer.Staff_number} updated successfully`;
    }

    // Define a resource function to delete a Course record via HTTP DELETE
    resource function delete deleteCourse(Course course) returns string {
        io:println(course);
        // Attempt to remove the course from the Course_table
        Course err = Course_table.remove(course.Course_code);
        if (err is Course) {
            return "Successfully Deleted: " + course.Course_code;
        } 
    }

    // Define a resource function to delete a Lecturer record via HTTP DELETE
    resource function delete deleteLecturer(Lecturers Lecturer) returns string {
        io:println(Lecturer);
        // Attempt to remove the lecturer from the Lecturer_Table
        Lecturers err = Lecturer_Table.remove(Lecturer.Staff_number);
        if (err is Lecturers) {
            return "Successfully Deleted: " + Lecturer.Staff_number;
        } 
    }

    // Define a resource function to retrieve all Course records via HTTP GET
    resource function get getAllCourses() returns Course[] {
        return Course_table.toArray();
    }

    // Define a resource function to retrieve all Lecturer records via HTTP GET
    resource function get getAllLecturers() returns Lecturers[] {
        return Lecturer_Table.toArray();
    }

    // Define a resource function to retrieve a Course record by its Course_code via HTTP GET
    resource function get getCourseByCoursecode(string Course_code) returns Course|string {
        foreach Course course in Course_table {
            if (course.Course_code === Course_code) {
                return course;
            }
        }
        return Course_code + " is invalid";
    }

    // Define a resource function to retrieve a Lecturer record by their Staff_number via HTTP GET
    resource function get getLecturerbyStaffnumber(string Staff_number) returns Lecturers|string {
        foreach Lecturers Lecturer in Lecturer_Table {
            if (Lecturer.Staff_number === Staff_number) {
                return Lecturer;
            }
        }
        return Staff_number + " is invalid";
    }

    // Define a resource function to retrieve all Course records with a specific NQF_level via HTTP GET
    resource function get getallCoursesByNQFnumber(string NQF_level) returns table<Course> {
        table <Course> getCoursesByNqf = from var course in Course_table
            where course.NQF_level === NQF_level
            select course;
        return getCoursesByNqf;
    }

    // Define a resource function to retrieve all Lecturer records with a specific First_course via HTTP GET
    resource function get getallLecturersbyCourses(string First_course) returns table<Lecturers> {
        table <Lecturers> getLecturerbyCourses = from var Lecturer in Lecturer_Table
            where Lecturer.First_course === First_course
            || Lecturer.Second_course === First_course
            || Lecturer.Third_course === First_course
            select Lecturer;
        return getLecturerbyCourses;
    }

    // Define a resource function to retrieve all Lecturer records with a specific Office_number via HTTP GET
    resource function get getallLecturersbyOffice(string Office_number) returns table<Lecturers> {
        table <Lecturers> getLecturerbyOffice = from var Lecturer in Lecturer_Table
            where Lecturer.Office_number === Office_number
            select Lecturer;
        return getLecturerbyOffice;
    }
}
