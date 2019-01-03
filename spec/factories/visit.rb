require 'securerandom'

FactoryBot.define do
  factory :visit do
    visit_token { SecureRandom.urlsafe_base64(9) }
    visitor_token { SecureRandom.urlsafe_base64(9) }
  end
end
