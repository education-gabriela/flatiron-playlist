class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :artist_id, limit: 8

      t.timestamps
    end

    add_index :songs, :title
    add_foreign_key :songs, :artists
  end
end
