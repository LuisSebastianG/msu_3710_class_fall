class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one_attached :profile_picture, dependent: :purge_later

    validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
#    validates :school_email, presence: true, uniqueness: true
    validates :major, presence: true
    validates :graduation_date, presence: true
    validate :acceptable_image
    validate :email_format
    def email_format
        unless email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
            errors.add(:email, "must be an @msudenver.edu email address")
        end
    end
 

    VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS", "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major"]
    validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}
    
    def default_profile_pic
        if profile_picture.attached?
            profile_picture
        else
            'portfolio_app\app\assets\images\default_profile_pic.jpg'
        end
    end

    def acceptable_image
        return unless profile_picture.attached?

        unless profile_picture.blob.byte_size <= 1.megabyte
            errors.add(:profile_picture, "is too big")
        end

        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(profile_picture.content_type)
            errors.add(:profile_picture, "must be a JPEG or PNG")
        end
    end

end
