require 'pana_validation_questionary_structure'

class ChangeColumnNames < ActiveRecord::Migration[5.1]
  def change
    5.times {|i| rename_column :pana_validation_questionaries,  "wellbeing#{i+1}", "who#{i+1}"}
    10.times {|i| rename_column :pana_validation_questionaries,  "panava#{i+1}", "pnv#{i+1}"}
    5.times {|i| rename_column :pana_validation_questionaries,  "swls#{i+1}", "swl#{i+1}"}

    10.times {|i| remove_column :pana_validation_questionaries, "emoji#{i+1}" }

    PanaValidationQuestionaryStructure.calculate_emoji_columns.each do |name|
      add_column :pana_validation_questionaries, name, :integer
    end
  end
end
