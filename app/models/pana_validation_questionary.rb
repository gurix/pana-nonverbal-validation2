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

  PanaValidationQuestionary.column_names.grep(/^sam1/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 8 })
  end

  PanaValidationQuestionary.column_names.grep(/^sam2/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 9 })
  end

  PanaValidationQuestionary.column_names.grep(/^sam3/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 10 })
  end

  PanaValidationQuestionary.column_names.grep(/^swls/).each do |column|
    validates(column, presence: true, if: proc { |q| q.page == 11 })
  end

  validates :emoji_matrix_1, presence: true, if: proc { |q| q.page ==  12 }
  validates :emoji_matrix_2, presence: true, if: proc { |q| q.page ==  13 }

  validates :page, presence: true
end
