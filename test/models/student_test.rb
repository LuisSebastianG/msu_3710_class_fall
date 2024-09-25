require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "Saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Nikola", school_email: "jokic@msudenver.edu", major: "CS", graduation_date: 2025-05-05)
    end
  end

  test "Saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Jokic", school_email: "jokic@msudenver.edu", major: "CS", graduation_date: 2025-05-05)
    end
  end

  test "Saving student without email" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", major: "CS", graduation_date: 2025-05-05)
    end
  end

  test "Saving student without major" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", school_email: "jokic@msudenver.edu", graduation_date: 2025-05-05)
    end
  end

   test "Saving student with non-unique email" do
    student = students(:one)
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", school_email: "jokic@msudenver.edu", major: "CS", graduation_date: 2025-05-05)
    end
  end

  test "Saving student without grad date" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic", school_email: "nikola@msudenver.edu", major: "CS")
    end
  end

  test "Saving first_name with a digit" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola1", last_name: "Jokic", school_email: "nikola@msudenver.edu", major: "CS", graduation_date: 2025-05-05)
    end
  end

  test "Saving last_name with a digit" do
    assert_raises ActiveRecord::RecordInvalid do 
      Student.create!(first_name: "Nikola", last_name: "Jokic1", school_email: "nikola@msudenver.edu", major: "CS", graduation_date: 2025-05-05)
    end
  end

  # test "the truth" do
  #   assert true
  # end
end
