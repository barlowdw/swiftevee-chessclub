class Member < ApplicationRecord
    validates :email, presence: true, 'valid_email_2/email': true, uniqueness: true
    validates_presence_of :first_name, :last_name, :date_of_birth

    def matches
        Match.where("member1_id = ?", self.id).or(Match.where("member2_id = ?", self.id))
    end

    def match_count
        self.matches.count
    end
end
