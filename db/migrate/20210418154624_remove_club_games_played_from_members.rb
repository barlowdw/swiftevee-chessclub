class RemoveClubGamesPlayedFromMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :club_games_played, :integer
  end
end
