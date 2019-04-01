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

  # Page 6 to 10
  5.times do |i|
    expect(page).to have_selector 'h1', text: 'Die folgenden Aussage betrifft Ihr Wohlbefinden in den letzten Tagen.'

    choose "pana_validation_questionary_who#{i + 1}_2"

    click_button 'Weiter'
  end

  5.times do |i|
    expect(subject.reload.pana_validation_questionary["who#{i + 1}"]).to eq 2
  end

  # Page 11 to 20
  10.times do |i|
    expect(page).to have_selector 'h1', text: 'Wie fühlen Sie sich gerade jetzt?'

    choose "pana_validation_questionary_pnv#{i + 1}_7"

    click_button 'Weiter'
  end

  10.times do |i|
    expect(subject.reload.pana_validation_questionary["pnv#{i + 1}"]).to eq 7
  end

  # Page 21 to 25
  5.times do |i|
    expect(page).to have_selector 'h1', text: 'Folgende Aussage können Sie zustimmen bzw. ablehnen.'

    choose "pana_validation_questionary_swls#{i + 1}_3"

    click_button 'Weiter'

    expect(subject.reload.pana_validation_questionary["swls#{i + 1}"]).to eq 3
  end

  # Page 26 and 27
  PanaValidationQuestionaryStructure::MATRIX_MAPPING.each_with_index do |row, index|
    item = row.flatten.sample

    expect(page).to have_selector 'h1', text: 'Wie fühlen Sie sich gerade jetzt?'
    expect(page).to have_content 'Wählen Sie spontan eines der 4 Gesichter aus.'

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
end
