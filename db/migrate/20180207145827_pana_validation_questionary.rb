class PanaValidationQuestionary < ActiveRecord::Migration[5.1]
  def change
    create_table :pana_validation_questionaries do |t|
      t.belongs_to :subject, index: true
      t.integer :page, default: 1
      t.timestamps
    end

    10.times {|i| add_column :pana_validation_questionaries, "emoji#{i+1}", :integer }
    5.times {|i| add_column :pana_validation_questionaries,  "wellbeing#{i+1}", :integer }
    20.times {|i| add_column :pana_validation_questionaries, "mrs#{i+1}", :integer }
    10.times {|i| add_column :pana_validation_questionaries, "panava#{i+1}", :integer }
    5.times {|i| add_column :pana_validation_questionaries,  "swls#{i+1}", :integer }
    3.times {|i| add_column :pana_validation_questionaries,  "sam#{i+1}", :integer }
  end
end
