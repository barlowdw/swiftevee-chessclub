class Ranking < ApplicationRecord
    validates_presence_of :member, :position
    belongs_to :member
    before_validation :assign_position
    before_create :assign_position
    attr_readonly :position

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
