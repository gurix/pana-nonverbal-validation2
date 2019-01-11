feature 'Subject' do
  scenario 'Create a new subject', js: true do
    visit root_path
    sleep 1

    visit new_subject_path(tic: 'LookingForFreedom')

    expect(page).to have_content 'Demographische Angaben'

    fill_in 'Alter', with: 42
    choose 'Weiblich'
    choose 'Kein Abschluss'
    choose 'Schweiz'

    expect { click_button 'Weiter' }.to change { Subject.count }.by(1)

    expect(page).to have_content 'Hinweis: Proband wurde erfolgreich erstellt.'

    subj = Subject.first
    expect(subj.visit).to be_valid
    expect(subj.user_agent).to have_content 'Mozilla/5.0'
    expect(subj.tic).to eq 'LookingForFreedom'
  end
end
