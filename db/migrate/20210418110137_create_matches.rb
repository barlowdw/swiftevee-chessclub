class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :member1_id
      t.integer :member2_id
      t.string :result

      t.timestamps

      t.index [:member1_id, :member2_id]
    end
  end

end
