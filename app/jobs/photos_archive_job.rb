class PhotosArchiveJob < ApplicationJob
  queue_as :photos

  rescue_from ActiveRecord::RecordNotFound do |exception|
    logger.error('Category not found!')
  end

  def perform(category_id)
    service = PhotosArchiveService.new(category_id)
    service.perform

    if File.exists?(service.archive_path)
      logger.info('Archive has been created!')
    else
      logger.error('Could not create ZIP')
    end
  end
end
