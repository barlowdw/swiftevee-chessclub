class MatchesController < ApplicationController
    def new
        @match = Match.new
        @members_select = {}

        Member.all.each do |member|
            @members_select["#{member.first_name} #{member.last_name}"] = member.id
        end
    end

    def create
        @match = Match.new(match_params)

        if @match.save
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def match_params
      params.require(:match).permit(:member1_id, :member2_id, :result)
    end
end
