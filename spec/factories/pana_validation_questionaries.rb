FactoryBot.define do
  factory :pana_validation_questionary do
    5.times { |i| add_attribute("who#{i + 1}") { i + 1 } }
    10.times { |i| add_attribute("pnv#{i + 1}") { i + 1 } }
    5.times { |i| add_attribute("swls#{i + 1}") { i + 1 } }
    2.times { |i| add_attribute("emoji_matrix_#{i + 1}") { i + 1 } }

    PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each_with_index do |name, index|
      add_attribute(name) { index + 1 }
    end
  end
end
