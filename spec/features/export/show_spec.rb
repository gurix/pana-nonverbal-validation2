feature 'Export page' do
  scenario 'Visit the export page requires to be authenticated' do
    visit export_path
    expect(page.status_code).to eq 401
  end

  scenario 'Visiting the export page returns a csv file' do
    # As https://github.com/rails/rails/issues/31200 is still open, we cannot test more then 10 cases
    5.times do
      create(:subject, pana_validation_questionary: build(:pana_validation_questionary),
                       visit: build(:visit))
    end

    basic_auth('', 'test')

    visit export_path
    # Testing header
    expect(page).to have_content 'id,age,gender,education,residence,created_at,tic,subject_id,page,updated_at,NA1_lo__NA2_hi,NA3_lo__NA3_hi,PA3_lo__PA1_hi,PA4_lo3__PA4_hi,who1,who2,who3,who4,who5,pnv1,pnv2,pnv3,pnv4,pnv5,pnv6,pnv7,pnv8,pnv9,pnv10,emoji_matrix_1,emoji_matrix_2,swls1,swls2,swls3,swls4,swls5,VA2_hi__VA2_lo,visit_token,visitor_token,ip,user_agent,referrer,landing_page,referring_domain,search_keyword,browser,os,device_type,screen_height,screen_width,country,region,city,postal_code,latitude,longitude,utm_source,utm_medium,utm_term,utm_content,utm_campaign,started_at' # rubocop:disable Metrics/LineLength

    # Testing if id and age is included in two rows everything else is not testet at the moment.
    expect(page).to have_content '1,42,f,1,ch'
    expect(page).to have_content '4,42,f,1,ch'
  end
end
