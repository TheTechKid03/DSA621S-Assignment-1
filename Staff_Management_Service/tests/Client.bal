import ballerina/io;
import ballerina/http;
import ballerina/test;

http:Client Client = check new ("http://localhost:9090");

//Test POST
function Test_POST_newLecturer() {
    
}

// Negative test function

@test:Config {}
function testServiceWithEmptyName() returns error? {
    http:Response response = check Client->get("/greeting/?name=");
    test:assertEquals(response.getTextPayload(), "name should not be empty!");
}

// After Suite Function

@test:AfterSuite
function afterSuiteFunc() {
    io:println("I'm the after suite function!");
}
