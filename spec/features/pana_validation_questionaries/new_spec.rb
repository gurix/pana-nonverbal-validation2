def range_select(value)
  script = 'window.slider.setValue(' + value.to_s + ', true, true)'
  page.execute_script(script)
end

def standard_questionary(subject) # rubocop:disable Metrics/MethodLength
  visit new_subject_pana_validation_questionary_path(subject)

  # Page 1 to 5
  PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each_with_index do |column, index|
    new_value = (index + 1)

    expect(page).to have_selector 'h1', text: 'Wie fühlen Sie sich gerade jetzt?'
    range_select(1)
    range_select(new_value)
    click_button 'Weiter'

    expect(subject.reload.pana_validation_questionary[column]).to eq new_value
  end

  expect(subject.reload.pana_validation_questionary.version).to eq 2

  # Page 6
  expect(page).to have_selector 'h1', text: 'Die folgenden Aussagen betreffen Ihr Wohlbefinden in den letzten Tagen.'

  PanaValidationQuestionary.column_names.grep(/^who/).each do |code|
    choose "pana_validation_questionary_#{code}_2"
  end

  click_button 'Weiter'

  PanaValidationQuestionary.column_names.grep(/^who/).each do |code|
    expect(subject.reload.pana_validation_questionary[code]).to eq 2
  end

  # Page 7
  expect(page).to have_selector 'h1', text: 'Wie fühlen Sie sich gerade jetzt?'

  PanaValidationQuestionary.column_names.grep(/^pnv/).each do |code|
    choose "pana_validation_questionary_#{code}_7"
  end

  click_button 'Weiter'

  PanaValidationQuestionary.column_names.grep(/^pnv/).each do |code|
    expect(subject.reload.pana_validation_questionary[code]).to eq 7
  end

  # Page 8
  expect(page).to have_selector 'h1', text: 'Wie fühlten Sie sich in den letzten Tagen?'

  find('label[for="pana_validation_questionary_sam1_1"]').click

  click_button 'Weiter'

  expect(subject.reload.pana_validation_questionary['sam1']).to eq 1

  click_button 'Weiter'

  # Page 9
  expect(page).to have_selector 'h1', text: 'Wie fühlten Sie sich in den letzten Tagen?'

  find('label[for="pana_validation_questionary_sam2_2"]').click

  click_button 'Weiter'

  expect(subject.reload.pana_validation_questionary['sam2']).to eq 2

  click_button 'Weiter'

  # Page 10
  expect(page).to have_selector 'h1', text: 'Wie fühlten Sie sich in den letzten Tagen?'

  find('label[for="pana_validation_questionary_sam3_3"]').click

  click_button 'Weiter'

  expect(subject.reload.pana_validation_questionary['sam3']).to eq 3

  click_button 'Weiter'

  PanaValidationQuestionary.column_names.grep(/^pnv/).each do |code|
    expect(subject.reload.pana_validation_questionary[code]).to eq 7
  end

  # Page 11
  expect(page).to have_selector 'h1', text: 'Folgende Aussagen können Sie zustimmen bzw. ablehnen.'
  PanaValidationQuestionary.column_names.grep(/^swls/).each do |code|
    choose "pana_validation_questionary_#{code}_3"
  end

  click_button 'Weiter'

  PanaValidationQuestionary.column_names.grep(/^swls/).each do |code|
    expect(subject.reload.pana_validation_questionary[code]).to eq 3
  end

  # Page 12 and 13
  PanaValidationQuestionaryStructure::MATRIX_MAPPING.each_with_index do |row, index|
    item = row.flatten.sample

    expect(page).to have_selector 'h1', text: 'Wie fühlen Sie sich gerade jetzt?'
    expect(page).to have_content 'Wählen Sie den Gesichtsausdruck, der Ihnen am besten entspricht.'

    find("img[alt='#{item}']").click

    click_button 'Weiter'

    expect(subject.reload.pana_validation_questionary["emoji_matrix_#{index + 1}"]).to eq item
  end
end

feature 'PanaValidationQuestionary' do
  scenario 'Create a new questionary', js: true do
    subject = create :subject

    standard_questionary(subject)

    expect(page).to have_content 'Herzlichen Dank für Ihre Teilnahme!'
  end

  scenario 'Create a new questionary for respondi', js: true do
    subject = create :subject, tic: 'Salem Aleikum'

    standard_questionary(subject)

    url = "https://mingle.respondi.com/s/#{PanaValidationQuestionariesController::RESPONDI_RETURN_CODE}/ospe.php3?c_0002=1&return_tic=#{subject.tic}" # rubocop:disable Metrics/LineLength

    expect(page).to have_content "If this wasn't a test, you'd be redirected to: #{url}"

    expect(page).not_to have_content 'Herzlichen Dank für Ihre Teilnahme!'
  end
end
