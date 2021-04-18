require 'rails_helper'

RSpec.describe Ranking, type: :model do
  describe "#create" do
    it "should persist member" do
      member = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))
      ranking = member.ranking
      ranking = Ranking.find(ranking.id)

      expect(ranking.member).to eq(member)
      expect(ranking.position).to eq(1)
    end

    it "should assign position automatically" do
      ranking1 = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10)).ranking
      ranking2 = Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13)).ranking
      ranking3 = Member.create!(first_name: "Kimmy", last_name: "Carr", email: "carr.j@gmail.com", date_of_birth: Date.new(1972, 9, 15)).ranking

      expect(ranking1.position).to eq(1)
      expect(ranking2.position).to eq(2)
      expect(ranking3.position).to eq(3)
    end
  end
end
