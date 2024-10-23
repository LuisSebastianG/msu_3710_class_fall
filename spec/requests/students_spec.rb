#Helper             HTTP Verb   Path                Controller Action     Description
#students_path      GET         /students           students#index        Display a list of all students
#new_student_path   GET         /students/new       students#new          Display a form for creating a new student
#                   POST        /students           students#create       Create a new student
#student_path       GET         /studetns/id        students#show         Display a specific student
#edit_student_path  GET         /students/id/edit   students#edit         Display a form for editing a student
#                   PATCH/PUT   /studetns/id        students#update       Update a specific student
#                   DELETE      /students/id        students#destroy      Delete a specific student
require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "returns a successful response" do
      get students_path
      expect(response).to have_http_status(200)
    end

    it "returns students with graduation date after a given date" do
      # Create test students
      student1 = Student.create!(first_name: "John", last_name: "Doe", school_email: "l@msudenver.edu", major: "Computer Science BS", graduation_date: "2024-01-01")
      student2 = Student.create!(first_name: "Jane", last_name: "Doe", school_email: "r@msudenver.edu", major: "Computer Science BS", graduation_date: "2023-01-01")

      # Perform the search
      get students_path, params: { search: { graduation_date: "2023-12-31" }, filter_type: "after" }

      # Check the response
      expect(response).to have_http_status(200)
      expect(response.body).to include("John Doe")
      expect(response.body).not_to include("Jane Doe")
    end

  end

  describe " POST /students" do
    it "creates a new student and returns a 201 status" do
      student_params = {
        student: {first_name: "Test", last_name: "Students", major: "Computer Science BS", minor: "Mathematics", school_email: "test@msudenver.edu", graduation_date: "2025-05-15"}
      }
      
      post students_path, params: student_params
      
      expect(response).to have_http_status(201)
      expect(Student.last.first_name).to eq("Test")
      expect(Student.last.last_name).to eq("Student")
    end

    it "does not create a student with invalid parameters and returns a 422 status" do
      invalid_params = {
        student: {first_name: "", last_name: "", major: "", minor: "", school_email: "", graduation_date: ""}
      }
      
      post student_path, params: invalid_params

      expect(response).to have_http_status(422)
      expect(Student.count).to eq(0)
    end

  end

  describe "GET / students/:id" do
    it "returns a 200 status for fetching student details" do
      student = Student.create!(first_name: "John", last_name: "Doe", major: "Computer Science BS", graduation_date: "2024-01-01")

      get student_path(student)

      expect(response).to have_http_status(200)
      expect(response.body).to include("John Doe")
    end

    it "returns correct student details in the response body" do
      student = Student.create!(first_name: "John", last_name: "Doe", school_email: "john.doe@msudenver.edu", major: "Computer Science BS", minor: "Mathematics", graduation_date: "2024-01-01")
      
      get student_path(student)

      expect(response).to have_http_status(200)
      expect(response.body).to include("John Doe")
      expect(response.body).to include("Computer Science BS")
      expect(response.body).to include("Mathematics")
      expect(response.body).to include("john.doe@msudenver.edu")
      expect(response.body).to include("2024-01-01")
    end

    it "returns a 404 status for a non-existent student" do
      get student_path(id: "non-existent-id")

      expect(response).to have_http_status(404)
    end
  
  end

  describe "DELETE /students/:id" do
    it "deletes a student and redirects to the index page" do
      student = Student.create!(first_name: "John", last_name: "Doe", school_email: "john@msudenver.edu", major: "Computer Science BS", graduation_date: "2024-01-01")

      expect {delete student_path(student)}.to change(Student, :count).by(-1)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(students_path)
    end

    it "returns a 404 status for deleting a non-existent student" do
      delete student_path(id: "non-existent-id")

      expect(response).to have_http_status(404)
    end

  end

end