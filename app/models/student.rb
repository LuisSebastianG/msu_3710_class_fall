class Student < ApplicationRecord
    validates :school_email, presence: true, uniqueness: true
end
