class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :author
      t.belongs_to :category
      t.timestamps
    end

    add_index :photos, :title
    add_index :photos, :author
  end
end
