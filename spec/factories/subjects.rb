FactoryBot.define do
  factory :subject do
    age { 42 }
    gender { 'f' }
    education { 1 }
    residence { 'ch' }
    group { 'gj' }
    user_agent { 'Mozilla/5.0 (Linux; U; Android 2.2; en-sa; HTC_DesireHD_A9191 Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1' } # rubocop:disable Metrics/LineLength
    accept_language { 'de-CH' }
  end
end
