class Ranking < ApplicationRecord
    validates_presence_of :member
    belongs_to :member
    before_create :assign_position

    def move(n)
        move_up = n < 0

        return if n == 0 || (move_up && self.position == 1) || (!move_up && self.position == max_position)

        ActiveRecord::Base.transaction do
            position_difference = move_up ? -1 : +1
            new_position = self.position + position_difference

            Ranking.find_by_position!(new_position).update!(position: self.position)
            self.update!(position: new_position)

            # Call recursive with n moving closer to 0 by 1 each call
            self.move(n - position_difference)
        end
    end

    private

    def assign_position
        self.position = next_position
    end

    def next_position
        max_position + 1
    end

    def max_position
        value = Ranking.maximum(:position)
        value = 0 unless value
        value
    end
end
