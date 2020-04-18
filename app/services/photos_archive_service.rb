require 'fileutils'
require 'zip'

class PhotosArchiveService
  attr_reader :category

  def initialize(category_id)
    @category = Category.find(category_id)
  end

  def perform
    build_archive(category.photos)
  end

  def archive_path
    Rails.root.join('public', 'archives', filename)
  end

  def filename
    "#{@category.title.parameterize}.zip"
  end

  private

  def build_archive(photos)
    create_store_dir

    Zip::File.open(archive_path, Zip::File::CREATE) do |zipfile|
      with_exist_files(photos).each_with_index do |photo, index|
        filename = "#{index}-#{photo.title.parameterize}.jpg"
        zipfile.add(filename, photo.file_path)
      end
    end
  end

  def create_store_dir
    FileUtils.mkdir_p(Rails.root.join('public', 'archives'))
  end

  def with_exist_files(photos)
    photos.select do |photo|
      photo.file_exists?
    end
  end
end
