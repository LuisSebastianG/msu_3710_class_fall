require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "Saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Nikola", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end

  test "Saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Jokic", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end

  test "Saving student without email" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", major: "CS")
    end
  end

  test "Saving student without major" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", school_email: "jokic@msudenver.edu")
    end
  end

   test "Saving student with non-unique email" do
    student = students(:one)
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end

  test "Saving student without grad date" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", school_email: "nikola@msudenver.edu", major: "CS")
    end
  end
=begin
  test "" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Jokic", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end

  test "" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Jokic", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end
=end  
  # test "the truth" do
  #   assert true
  # end
end
