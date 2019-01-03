FactoryBot.define do
  factory :pana_validation_questionary do
    5.times {|i| add_attribute("who#{i+1}") { i+1 }}
    20.times {|i| add_attribute("mrs#{i+1}") { i+1 }}
    10.times {|i| add_attribute("pnv#{i+1}") { i+1 }}
    5.times {|i| add_attribute("swl#{i+1}") { i+1 }}
    20.times { |i| add_attribute("pan#{i+1}") { i+1 }}
    3.times { |i| add_attribute("sam#{i+1}") { i+1 }}

    PanaValidationQuestionaryStructure.calculate_emoji_columns.each_with_index do |name, index|
      add_attribute(name) { index+1 }
    end
  end
end
