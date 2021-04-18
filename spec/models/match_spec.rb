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

    it "should persist result" do
      member1 = Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10))
      member2 = Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13))
      
      expect(Match.create!(member1: member1, member2: member2, result: :member1_win).result.to_sym).to eq(:member1_win)
      expect(Match.create!(member1: member1, member2: member2, result: :member2_win).result.to_sym).to eq(:member2_win)
      expect(Match.create!(member1: member1, member2: member2, result: :draw).result.to_sym).to eq(:draw)
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

  describe "update ranking" do
    before(:each) do
      @rankings = [
        Member.create!(first_name: "Derrick", last_name: "Barlow", email: "barlow.dw@gmail.com", date_of_birth: Date.new(1990, 1, 10)).ranking,
        Member.create!(first_name: "Bill", last_name: "Bailey", email: "bailey.mr@gmail.com", date_of_birth: Date.new(1965, 1, 13)).ranking,
        Member.create!(first_name: "Kimmy", last_name: "Carr", email: "carr.j@gmail.com", date_of_birth: Date.new(1972, 9, 15)).ranking,
        Member.create!(first_name: "Ricky", last_name: "Gervais", email: "gervais.rd@gmail.com", date_of_birth: Date.new(1961, 6, 25)).ranking
      ]
    end

    describe "higher player wins" do
      it "should not change rankings 1 v 2" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[1].member, result: :member1_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should not change rankings 1 v 2 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[1].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should not change rankings 1 v 3" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[2].member, result: :member1_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should not change rankings 1 v 3 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[2].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should not change rankings 1 v 4" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[3].member, result: :member1_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should not change rankings 1 v 4 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[3].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end
    end

    describe "draw" do
      it "should not change rankings 1 v 2" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[1].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should not change rankings 1 v 2 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[1].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4])
      end

      it "should move 3 to 2 for 1 v 3" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[2].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 3, 2, 4])
      end

      it "should move 3 to 2 for 1 v 3 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[2].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 3, 2, 4])
      end

      it "should move 4 to 3 for 1 v 4" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[3].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 4, 3])
      end

      it "should move 4 to 3 for 1 v 4 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[3].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 4, 3])
      end
    end

    describe "lower player wins" do
      it "should swap rankings 1 v 2" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[1].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 1, 3, 4])
      end

      it "should swap rankings 1 v 2 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[1].member, result: :member1_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 1, 3, 4])
      end

      it "should move 1 to 3 and 3 to 2 rankings 1 v 3" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[2].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([3, 1, 2, 4])
      end

      it "should move 1 to 3 and 3 to 2 for 1 v 3 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[2].member, result: :member1_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([3, 1, 2, 4])
      end

      it "should move 1 to 2 and 4 to 3 for 1 v 4" do
        Match.create!(member1: @rankings[0].member, member2: @rankings[3].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 1, 4, 3])
      end

      it "should move 1 to 2 and 4 to 3 for 1 v 4 [swapped]" do
        Match.create!(member2: @rankings[0].member, member1: @rankings[3].member, result: :member1_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([2, 1, 4, 3])
      end
    end
  end

  describe "update ranking - extended" do
    before(:each) do
      @rankings = [
        Member.create!(first_name: "1", last_name: "0", email: "0001@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "2", last_name: "0", email: "0002@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "3", last_name: "0", email: "0003@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "4", last_name: "0", email: "0004@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "5", last_name: "0", email: "0005@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "6", last_name: "0", email: "0006@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "7", last_name: "0", email: "0007@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "8", last_name: "0", email: "0008@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "9", last_name: "0", email: "0009@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "10", last_name: "0", email: "0010@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "11", last_name: "0", email: "0011@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "12", last_name: "0", email: "0012@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "13", last_name: "0", email: "0013@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "14", last_name: "0", email: "0014@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "15", last_name: "0", email: "0015@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
        Member.create!(first_name: "16", last_name: "0", email: "0016@gmail.com", date_of_birth: Date.new(1990, 1, 1)).ranking,
      ]
    end

    describe "10 v 11, draw" do
      it "should not update rankings" do
        Match.create!(member2: @rankings[9].member, member1: @rankings[10].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])
      end
    end

    describe "10 v 15, draw" do
      it "should update 15's ranking" do
        Match.create!(member2: @rankings[9].member, member1: @rankings[14].member, result: :draw)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 14, 16])
      end
    end

    describe "10 v 16, 16 wins" do
      it "should both rankings" do
        Match.create!(member1: @rankings[9].member, member2: @rankings[15].member, result: :member2_win)

        expect(@rankings.map { |ranking| ranking.reload.position }).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 10, 12, 14, 15, 16, 13])
      end
    end
  end
end
