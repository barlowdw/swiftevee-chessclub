class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.integer :member_id
      t.integer :position

      t.timestamps

      t.index :member_id, unique: true
      t.index :position
    end
  end
end
