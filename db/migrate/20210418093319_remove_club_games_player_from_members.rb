class RemoveClubGamesPlayerFromMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :field_name, :club_games_played
  end
end
