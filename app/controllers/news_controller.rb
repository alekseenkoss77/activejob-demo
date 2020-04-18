# app/controllers/news_controller.rb
class NewsController < ApplicationController
  def show
    @news = News.find(params[:id])
  end
end

# app/jobs/collect_user_stats_job.rb
class CollectUserStatsJob < ApplicationJob
  def perform(ip, utm_params)
    response = GeoIPClient.request(ip)
    StatsCollectorService.collect(utm_params, response)
  end
end
