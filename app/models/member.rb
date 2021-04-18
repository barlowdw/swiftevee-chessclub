class Member < ApplicationRecord
    validates :email, presence: true, 'valid_email_2/email': true, uniqueness: true
    validates_presence_of :first_name, :last_name, :date_of_birth
end
