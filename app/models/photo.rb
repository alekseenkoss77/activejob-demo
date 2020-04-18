class Photo < ApplicationRecord
  belongs_to :category

  has_one_attached :file

  def file_path
    ActiveStorage::Blob.service.path_for(file.key)
  end

  def file_exists?
    File.exists?(file_path)
  end
end
