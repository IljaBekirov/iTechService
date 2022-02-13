class SendSmsWithReviewUrlJob  < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(review_id)
    review = Review.find review_id
    service_job = review.service_job
    puts message = Setting.request_review_text(service_job.department)
    puts review_url = "#{root_url}review/#{review.token}"
    puts s1 = SendSMS.call(number: review.phone, message: message).success?
    sleep(1)
    puts s2 = SendSMS.call(number: review.phone, message: review_url).success?
    if s1 && s2
      review.update(sent_at: DateTime.now, status: :sent)
    else
      review.update(status: :error)
    end
    puts review.status
  end
end