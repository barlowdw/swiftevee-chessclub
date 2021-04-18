class Match < ApplicationRecord
    belongs_to :member1, class_name: 'Member', foreign_key: "member1_id"
    belongs_to :member2, class_name: 'Member', foreign_key: "member2_id"

    validates_presence_of :member1, :member2, :result

    enum result: { member1_win: 0, member2_win: 1, draw: 2 }

    after_create :update_ranking

    private

    def update_ranking
        case self.result.to_sym
        when :draw
            update_ranking_draw
        else
            update_ranking_win
        end
    end

    def update_ranking_draw
        return if (self.member1.ranking.position - self.member2.ranking.position).abs == 1

        lowest_member.ranking.move(-1)
    end

    def update_ranking_win
        return if highest_member_won

        lowest_member_position_move = (lowest_member.ranking.position - highest_member.ranking.position) / 2

        highest_member.ranking.move(1)
        lowest_member.ranking.move(-lowest_member_position_move)
    end

    def highest_member_won
        highest_member == winning_member
    end

    def highest_member
        self.member1.ranking.position < self.member2.ranking.position ? self.member1 : self.member2
    end

    def winning_member
        case self.result.to_sym
        when :member1_win
            self.member1
        when :member2_win
            self.member2
        else
            nil
        end
    end

    def lowest_member
        highest_member.id == self.member1.id ? self.member2 : self.member1
    end
end
