class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :author_id, null: false
      t.integer :track_id, null: false
      t.text :description, null: false
      t.timestamps
    end

    add_index :notes, :author_id
    add_index :notes, :track_id
  end
end
