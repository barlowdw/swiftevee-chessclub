class Match < ApplicationRecord
    belongs_to :member1, class_name: 'Member', foreign_key: "member1_id"
    belongs_to :member2, class_name: 'Member', foreign_key: "member2_id"

    validates_presence_of :member1, :member2, :result

    enum result: [ :member1_win, :member2_win, :draw ]
end
