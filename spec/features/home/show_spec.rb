feature 'Home page' do
  scenario 'Visiting the home page assigns randomly a group' do
    stub_const("PanaValidationQuestionaryStructure::MAPPING", abc: [:a,:b])

    visit root_path
    expect(page).to have_content 'Entwicklung einer Emoji-Skala zur Erfassung positiver und negativer Aktivierung'
    expect(page).to have_link 'Umfrage starten', href: new_subject_path(group: 'abc')
  end

  scenario 'Visit homepage using an available group' do
    visit '/start/gj'
    expect(page).to have_link 'Umfrage starten', href: new_subject_path(group: 'gj')
  end

  scenario 'Visit homepage using an invalid group trows an error' do
    visit '/start/ganja'

    expect(page).not_to have_link 'Umfrage starten', href: new_subject_path(group: 'ganja')
    expect(page).to have_content 'Die Gruppe «ganja» ist nicht zulässig. Folgende Gruppen sind verfügbar: gj, ms, sb1, sb2'
  end

  scenario 'Visit homepage including a tic code inlcuding this code to start the questionary' do
    stub_const("PanaValidationQuestionaryStructure::MAPPING", abc: [:a,:b])

    visit root_path(tic: 'LookingForFreedom')
    expect(page).to have_link 'Umfrage starten', href: new_subject_path(group: 'abc', tic: 'LookingForFreedom')
  end
end
