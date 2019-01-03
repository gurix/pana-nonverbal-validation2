feature 'Subject' do
  scenario 'Raises an error when no group is set' do
    expect{ visit new_subject_path }.to raise_error 'missing group'
  end

  scenario 'Raises an error when an unknown group is set' do
    expect{ visit new_subject_path(group: 'haschisch') }.to raise_error 'haschisch is not available'
  end

  scenario 'Create a new subject', js: true do
    visit root_path
    sleep 1

    visit new_subject_path(group: 'gj', tic: 'LookingForFreedom')

    expect(page).to have_content 'Demographische Angaben'

    fill_in 'Alter', with: 42
    choose 'Weiblich'
    choose 'Kein Abschluss'
    choose 'Schweiz'

    expect { click_button 'Weiter' }.to change {Subject.count}.by(1)

    expect(page).to have_content 'Hinweis: Proband wurde erfolgreich erstellt.'

    subj = Subject.first
    expect(subj.visit).to be_valid
    expect(subj.user_agent).to have_content 'Mozilla/5.0'
    expect(subj.accept_language.first.name).to eq 'German'
    expect(subj.tic).to eq 'LookingForFreedom'
  end
end
