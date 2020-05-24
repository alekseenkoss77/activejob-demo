class ReportsMailer < ApplicationMailer
  def visit_stats(email, file_path)
    return if email.blank? || file_path.blank?

    @file_path = file_path
    mail to: email, subject: 'Users visits report'
  end
end
