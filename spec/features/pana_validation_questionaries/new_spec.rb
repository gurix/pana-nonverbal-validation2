def range_select(name, value)
  selector = %(input[type=range][name=\\"#{name}\\"])
  script = %-$("#{selector}").val(#{value}).trigger('change')-
  page.execute_script(script)
end

def standard_questionary(subject) # rubocop:disable Metrics/MethodLength
  visit new_subject_pana_validation_questionary_path(subject)

  # Page 1 to 5
  PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each_with_index do |column, index|
    new_value = (index + 1) * 10

    expect(page).to have_selector 'h1', text: 'Wie fühlten Sie sich in den letzten Tagen?'

    range_select(column, new_value)

    click_button 'Weiter'

    expect(subject.reload.pana_validation_questionary[column]).to eq new_value
  end

  # Page 6
  expect(page).to have_selector 'h1', text: 'Die folgenden Aussagen betreffen Ihr Wohlbefinden in den letzten Tagen.'

  5.times do |i|
    choose "pana_validation_questionary_who#{i + 1}_2"
  end

  click_button 'Weiter'

  5.times do |i|
    expect(subject.reload.pana_validation_questionary["who#{i + 1}"]).to eq 2
  end

  # Page 7
  expect(page).to have_selector 'h1', text: 'Wie fühlten Sie sich in den letzten Tagen?'

  10.times do |i|
    choose "pana_validation_questionary_pnv#{i + 1}_7"
  end

  click_button 'Weiter'

  10.times do |i|
    expect(subject.reload.pana_validation_questionary["pnv#{i + 1}"]).to eq 7
  end

  # Page 8 and 9
  PanaValidationQuestionaryStructure::MATRIX_MAPPING.each_with_index do |row, index|
    item = row.flatten.sample

    expect(page).to have_selector 'h1', text: 'Wie fühlten Sie sich in den letzten Tagen?'
    expect(page).to have_content 'Wählen Sie spontan eines der 4 Gesichter aus.'

    find("img[alt='#{item}']").click

    click_button 'Weiter'

    expect(subject.reload.pana_validation_questionary["emoji_matrix_#{index + 1}"]).to eq item
  end

  # Page 10
  expect(page).to have_selector 'h1', text: 'Es folgen fünf Aussagen, denen Sie zustimmen bzw. die Sie ablehnen können.'

  5.times do |i|
    choose "pana_validation_questionary_swls#{i + 1}_3"
  end

  click_button 'Weiter'
end

feature 'PanaValidationQuestionary' do
  scenario 'Create a new questionary', js: true do
    subject = create :subject

    standard_questionary(subject)

    expect(page).to have_content 'Herzlichen Dank für Ihre Teilnahme!'
  end
end
