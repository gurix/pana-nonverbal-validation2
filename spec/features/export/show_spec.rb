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
    expect(page).to have_content 'id,age,gender,education,residence,created_at,tic,subject_id,page,updated_at,who1,who2,who3,who4,who5,mrs1,mrs2,mrs3,mrs4,mrs5,mrs6,mrs7,mrs8,mrs9,mrs10,mrs11,mrs12,mrs13,mrs14,mrs15,mrs16,mrs17,mrs18,mrs19,mrs20,pnv1,pnv2,pnv3,pnv4,pnv5,pnv6,pnv7,pnv8,pnv9,pnv10,swl1,swl2,swl3,swl4,swl5,sam1,sam2,sam3,PA3_lo__PA1_hi,NA2_lo__NA1_hi,PA4_hi__PA4_lo3,VA1_lo__NA3_lo,VA1_hi__VA2_lo,PA1_lo__PA1_hi,NA3_lo__NA2_hi,PA3_hi__PA3_lo,NA1_hi__NA1_lo,VA2_hi__VA2_lo,VA1_hi__VA1_lo,PA1_hi__PA1_lo,PA2_lo__PA2_hi1,NA2_lo__NA2_hi,VA2_lo__VA2_hi,PA3_lo__PA3_hi,NA3_lo__NA3_hi,NA4_hi__NA4_lo,PA2_lo__PA2_hi5,pan1,pan2,pan3,pan4,pan5,pan6,pan7,pan8,pan9,pan10,pan11,pan12,pan13,pan14,pan15,pan16,pan17,pan18,pan19,pan20,visit_token,visitor_token,ip,user_agent,referrer,referring_domain,landing_page,browser,os,device_type,country,region,city,utm_source,utm_medium,utm_term,utm_content,utm_campaign,started_at' # rubocop:disable Metrics/LineLength

    # Testing if id and age is included in two rows everything else is not testet at the moment.
    expect(page).to have_content '1,42'
    expect(page).to have_content '4,42'
  end
end
