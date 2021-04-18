require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "#valid?" do
    it "should not be valid when empty" do
      expect(Member.new).not_to be_valid
    end

    it "should  notbe valid without first_name" do
      expect(Member.new(last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should  notbe valid without last_name" do
      expect(Member.new(first_name: "Derrick", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should  notbe valid without email" do
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", date_of_birth: Date.new(1990, 1, 10))).not_to be_valid
    end

    it "should  notbe valid without date_of_birth" do
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
end
