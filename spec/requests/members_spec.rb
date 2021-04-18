require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "GET index" do
    it "returns a successful response" do
      get members_path
      expect(response).to be_successful
    end
  end

  describe "GET new" do
    it "returns a successful response" do
      get new_member_path
      expect(response).to be_successful
    end
  end

  describe "GET show" do
    it "returns a successful response" do
      member = Member.create!
      get member_path member
      expect(response).to be_successful
    end
  end

  describe "GET edit" do
    it "returns a successful response" do
      member = Member.create!
      get edit_member_path member
      expect(response).to be_successful
    end
  end

  describe "POST create" do
    it "creates member" do
      member_params = { 
        member: {
          first_name: "Derrick",
          last_name: "Barlow",
          email: "barlow.dw@gmail.com",
          date_of_birth: Date.new(1990, 1, 10),
        }
      }

      post members_path, params: member_params.to_json, headers: { "Content-Type": "application/json" }

      member = Member.last

      expect(response).to redirect_to(member_path(member))

      expect(member.first_name).to eq("Derrick")
      expect(member.last_name).to eq("Barlow")
      expect(member.email).to eq("barlow.dw@gmail.com")
      expect(member.date_of_birth).to eq(Date.new(1990, 1, 10))
    end
  end

  describe "PUT update" do
    it "updates member" do
      member = Member.create!(first_name: "Derrick", last_name: "Barlow", date_of_birth: Date.new(1990, 1, 10), email: "barlow.dw@gmail.com")

      expect(member.first_name).to eq("Derrick")
      expect(member.last_name).to eq("Barlow")
      expect(member.email).to eq("barlow.dw@gmail.com")
      expect(member.date_of_birth).to eq(Date.new(1990, 1, 10))

      member_params = { 
        member: {
          first_name: "Bill",
          last_name: "Barlow",
          email: "barlow.dw@gmail.com",
          date_of_birth: Date.new(1990, 1, 10),
        }
      }

      put member_path(member), params: member_params.to_json, headers: { "Content-Type": "application/json" }

      member = Member.find(member.id)

      expect(response).to redirect_to(member_path(member))

      expect(member.first_name).to eq("Bill")
      expect(member.last_name).to eq("Barlow")
      expect(member.email).to eq("barlow.dw@gmail.com")
      expect(member.date_of_birth).to eq(Date.new(1990, 1, 10))
    end
  end

  describe "DELETE destroy" do
    it "deletes member" do
      member = Member.create!(first_name: "Derrick", last_name: "Barlow", date_of_birth: Date.new(1990, 1, 10), email: "barlow.dw@gmail.com")

      delete member_path(member)

      expect(response).to redirect_to(members_path)

      expect { Member.find(member.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
