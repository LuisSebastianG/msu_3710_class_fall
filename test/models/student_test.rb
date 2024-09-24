require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "should raise error when saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Nikola", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end
  # test "the truth" do
  #   assert true
  # end
end

class Student < ApplicationRecord
  validates :first_name, presence: true
end