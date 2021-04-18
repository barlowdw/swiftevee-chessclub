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

  describe "#move" do
    before(:each) do
      @rankings = [
        Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10)).ranking,
        Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13)).ranking,
        Member.create!(first_name: "Kimmy", last_name: "Carr", email: "carr.j@gmail.com", date_of_birth: Date.new(1972, 9, 15)).ranking,
        Member.create!(first_name: "Ricky", last_name: "Gervais", email: "gervais.rd@gmail.com", date_of_birth: Date.new(1961, 6, 25)).ranking
      ]
    end

    it "should move up 1" do
      @rankings[2].move(-1)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 3, 2, 4])
    end

    it "should move up 2" do
      @rankings[2].move(-2)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 3, 1, 4])
    end

    it "should move up 3" do
      @rankings[3].move(-3)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 3, 4, 1])
    end

    it "should move down 1" do
      @rankings[2].move(1)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 4, 3])
    end

    it "should move down 2" do
      @rankings[1].move(2)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 4, 2, 3])
    end

    it "should move down 3" do
      @rankings[0].move(3)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([4, 1, 2, 3])
    end

    it "should not move up 1 if at top" do
      @rankings[0].move(-1)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
    end

    it "should not move down 1 if at bottom" do
      @rankings[3].move(1)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
    end

    it "should not move past top" do
      @rankings[2].move(-5)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 3, 1, 4])
    end

    it "should not move past bottom" do
      @rankings[1].move(5)

      expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 4, 2, 3])
    end
  end
end
