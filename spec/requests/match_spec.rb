require 'rails_helper'

RSpec.describe "Matches", type: :request do
  describe "GET new" do
    it "returns a successful response" do
      get new_member_path
      expect(response).to be_successful
    end
  end

  describe "POST create" do
    it "creates member" do
      member1 = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))
      member2 = Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13))

      member_params = { 
        match: {
          member1_id: member1.id,
          member2_id: member2.id,
          result: :member1_win
        }
      }

      post matches_path, params: member_params.to_json, headers: { "Content-Type": "application/json" }

      expect(response).to redirect_to(root_path)

      match = Match.last

      expect(match.member1).to eq(member1)
      expect(match.member2).to eq(member2)
      expect(match.result.to_sym).to eq(:member1_win)
    end

    it "stays on screen if member is invalid" do
      match_params = { 
        match: {
          member1_id: nil,
          member2_id: nil,
          result: :member1_win
        }
      }

      post matches_path, params: match_params.to_json, headers: { "Content-Type": "application/json" }

      expect(response).not_to have_http_status(:redirect)
    end
  end
end
