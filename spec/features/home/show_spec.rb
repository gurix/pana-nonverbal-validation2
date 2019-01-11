feature 'Home page' do
  scenario 'Visit homepage including a tic code inlcuding this code to start the questionary' do
    stub_const('PanaValidationQuestionaryStructure::MAPPING', abc: %i[a b])

    visit root_path(tic: 'LookingForFreedom')
    expect(page).to have_link 'Umfrage starten', href: new_subject_path(tic: 'LookingForFreedom')
  end
end
