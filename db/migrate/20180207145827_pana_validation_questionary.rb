class PanaValidationQuestionary < ActiveRecord::Migration[5.1]
  def change
    create_table :pana_validation_questionaries do |t|
      t.belongs_to :subject, index: true
      t.integer :page, default: 1
      t.timestamps
    end

    # Five pana emojis using the vertical slider.
    PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each do |name|
      add_column :pana_validation_questionaries, name, :integer
    end

    # WHO Items
    5.times {|i| add_column :pana_validation_questionaries,  "who#{i+1}", :integer }

    # Verbal Panava Items
    10.times {|i| add_column :pana_validation_questionaries, "pnv#{i+1}", :integer }

    # Two pages with the 2x2 matrix in which one emoji has to be choosen
    add_column :pana_validation_questionaries, :emoji_matrix_1, :string
    add_column :pana_validation_questionaries, :emoji_matrix_2, :string

    # Satisfaction With Life Scale (SWLS)
    5.times {|i| add_column :pana_validation_questionaries,  "swls#{i+1}", :integer }
  end
end
