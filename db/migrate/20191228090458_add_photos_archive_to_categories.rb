class AddPhotosArchiveToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :photos_archive_path, :text
  end
end
