class PanaValidationQuestionary < ApplicationRecord
  belongs_to :subject

  # Validate presence for each pair of emojis
  PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each_with_index do |column, column_index|
    validates(column, presence: true, if: proc { |q| q.page == (column_index + 1) })
  end

  PanaValidationQuestionary.column_names.grep(/^who/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 6 })
  end

  PanaValidationQuestionary.column_names.grep(/^pnv/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 7 })
  end

  PanaValidationQuestionary.column_names.grep(/^swls/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 8 })
  end

  validates :emoji_matrix_1, presence: true, if: proc { |q| q.page ==  9 }
  validates :emoji_matrix_2, presence: true, if: proc { |q| q.page ==  10 }

  validates :page, presence: true
end
