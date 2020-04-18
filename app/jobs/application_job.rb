class ApplicationJob < ActiveJob::Base
  def self.logger
    Sidekiq.logger
  end

  def logger
    self.class.logger
  end
end
