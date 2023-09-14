import ballerina/http;
public type Lecturers record {|
    readonly int Staff_number;
    string office_number;
    string Staff_name;
    string title;
    string courses;
|};

public final table<Lecturers> key(Staff_number) LecturersTable = table [
    {Staff_number: 200101, office_number: "A01", Staff_name: "Loini Iiyambo", title:"Lecturer", courses: "CNT"},
   {Staff_number: 200110, office_number: "A09", Staff_name: "Micheal Peterson", title:"Lecturer", courses: "WLT"},
   {Staff_number: 200100, office_number: "B02", Staff_name: "Eliaser Hafunda", title:"Lecturer", courses: "NPG"},
   ];
service /Lecturers/status on new http:Listener(9000) {
	resource function get Staff_number() returns Lecturers[] {
        return LecturersTable.toArray();
    }
    resource function post office_number(@http:Payload Lecturers[] Lecturers)
                                    returns Lecturers[]|ConflictingStaff_numberError {

    string[] conflictingStaff_number = from Lecturers Lecturers in Lecturers
        where LecturersTable.hasKey(Lecturer.Staff_number)
        select Lecturers.Staff_number;

    if conflictingStaff_number.length() > 0 {
        return {
            body: {
                errmsg: string:'join(" ", "Conflicting Staff number:", ...conflictingStaff_number)
            }
        };
    } else {
        Lecturers.forEachLecturers => LecturersTable.add(Lecturers);
        return Lecturers;
    }
}
}