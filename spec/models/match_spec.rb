require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "#create" do
    it "should persist member" do
      member1 = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))
      member2 = Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13))
      
      Match.create!(member1: member1, member2: member2, result: :member1_win)
      
      match = Match.last

      expect(match.member1).to eq(member1)
      expect(match.member2).to eq(member2)
    end
  end

  describe "#valid?" do
    it "should be valid with members" do
      match = Match.new(
        member1: Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10)),
        member2: Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13)),
        result: :member1_win
      )
      expect(match).to be_valid
    end
  end
end
