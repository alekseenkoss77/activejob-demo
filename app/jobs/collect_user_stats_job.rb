class CollectUserStatsJob
  def perform(ip, utm_params)
    response = GeoIPClient.request(ip)
    StatsCollectorService.collect(utm_params, response)
  end
end
