feature 'Home page' do
  scenario 'Visit homepage including a tic code inlcuding this code to start the questionary' do
    stub_const('PanaValidationQuestionaryStructure::MAPPING', abc: %i[a b])

    visit root_path(tic: 'LookingForFreedom')
    expect(page).to have_link 'Umfrage starten', href: new_subject_path(tic: 'LookingForFreedom')
  end

  scenario 'Visit the homepage the resolution has to be at least 1000px', js: true do
    visit root_path

    expect(page).to have_content 'Entwicklung einer Emoji-Skala zur Erfassung positiver und negativer Aktivierung'
    expect(page).not_to have_content 'Für diese Befragung ist Ihre Bildschirmauflösung zu gering.'

    page.driver.browser.manage.window.resize_to(800, 800)

    expect(page).not_to have_content 'Entwicklung einer Emoji-Skala zur Erfassung positiver und negativer Aktivierung'
    expect(page).to have_content 'Für diese Befragung ist Ihre Bildschirmauflösung zu gering.'

    page.driver.browser.manage.window.resize_to(1024, 800)

    expect(page).to have_content 'Entwicklung einer Emoji-Skala zur Erfassung positiver und negativer Aktivierung'
    expect(page).not_to have_content 'Für diese Befragung ist Ihre Bildschirmauflösung zu gering.'
  end
end
