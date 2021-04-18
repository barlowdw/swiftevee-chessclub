class Member < ApplicationRecord
    validates_presence_of :first_name, :last_name, :date_of_birth, :email
end
