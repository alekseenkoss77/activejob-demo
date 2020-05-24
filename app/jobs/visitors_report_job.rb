# frozen_string_literal: true

require 'csv'

class VisitorsReportJob < ApplicationJob
  queue_as :reports

  REPORT_FILENAME = "visitors_stats.csv"

  def perform(email)
    ::CSV.open(Rails.root.join('public', REPORT_FILENAME), 'w+') do |doc|
      doc << ['IPAddress', 'City', 'Country', 'UserAgent', 'TotalVisits', 'TimeSpent', 'CreatedAt']

      VisitorStat.find_each(batch_size: 5000) do |stat|
        doc << [
          stat.ip_address,
          stat.city,
          stat.country,
          stat.user_agent,
          stat.visits,
          stat.time_spent,
          stat.created_at
        ]   
      end

      doc.close if doc.eof?
    end

    ReportsMailer.visit_stats(email, REPORT_FILENAME).deliver_later
  end
end
