class Student < ApplicationRecord
    validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true
    validates :major, presence: true
    validates :graduation_date, presence: true
end
