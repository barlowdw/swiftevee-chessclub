require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "#create" do
    it "should create ranking" do
      member = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))

      expect(member.ranking).not_to be_nil
    end
  end

  describe "#valid?" do
    it "should not be valid when empty" do
      expect(Member.new).not_to be_valid
    end

    it "should not be valid without first_name" do
      expect(Member.new(last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should not be valid without last_name" do
      expect(Member.new(first_name: "Derrick", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should notbe valid without email" do
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should not be valid without date_of_birth" do
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com")).not_to be_valid
    end

    it "should be valid with basic attributed" do
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))).to be_valid
      expect(Member.new(first_name: "Bill", last_name: "Bailey", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1965, 1, 13))).to be_valid
    end

    it "should not be valid with invalid email" do
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "barlow.dwgmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "@gmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "gmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should not be valid with duplicate email" do
      Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))
      expect(Member.new(first_name: "Bill", last_name: "Bailey", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1965, 1, 13))).not_to be_valid
    end
  end

  describe "#matches" do
    it "should retrieve all matches" do
      member1 = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))
      member2 = Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13))
      member3 = Member.create!(first_name: "Kimmy", last_name: "Carr", email: "carr.j@gmail.com", date_of_birth: Date.new(1972, 9, 15))
      member4 = Member.create!(first_name: "Ricky", last_name: "Gervais", email: "gervais.rd@gmail.com", date_of_birth: Date.new(1961, 6, 25))
      
      match1 = Match.create!(member1: member1, member2: member2, result: :member1_win)
      match2 = Match.create!(member1: member3, member2: member1, result: :member2_win)
      match3 = Match.create!(member1: member1, member2: member3, result: :draw)
      match4 = Match.create!(member1: member4, member2: member1, result: :member1_win)

      expect(member1.matches.count).to eq 4
      expect(member2.matches.count).to eq 1

      member1MatchesIds = member1.matches.all.map { |match| match.id }
      member2MatchesIds = member2.matches.all.map { |match| match.id }

      expect(member1MatchesIds).to include match1.id
      expect(member1MatchesIds).to include match2.id
      expect(member1MatchesIds).to include match3.id
      expect(member1MatchesIds).to include match4.id

      expect(member2MatchesIds).to include match1.id
      expect(member2MatchesIds).not_to include match2.id
      expect(member2MatchesIds).not_to include match3.id
      expect(member2MatchesIds).not_to include match4.id
    end
  end
end
