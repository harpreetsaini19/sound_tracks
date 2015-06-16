class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :artist_name
      t.integer :user_id
      t.foreign_key :users, column: :user_id

      t.timestamps
    end
  end
end
