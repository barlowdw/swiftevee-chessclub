require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "#valid?" do
    it "should not be valid when empty" do
      expect(Member.new).not_to be_valid
    end

    it "should be valid with basic attributed" do
      expect(Member.new(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))).to be_valid
    end
  end
end
