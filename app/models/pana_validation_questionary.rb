class PanaValidationQuestionary < ApplicationRecord
  belongs_to :subject

  # Validate presence for each pair of emojis
  PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each_with_index do |column, column_index|
    validates(column, presence: true, if: proc { |q| q.page == (column_index + 1) })
  end

  # Validate presence for each item of the rest of the survey
  PanaValidationQuestionaryStructure.structure[0..1].each_with_index do |page, page_index|
    page.each do |item|
      validates(item, presence: true, if: proc { |q| q.page == (page_index + 6) })
    end
  end

  validates :emoji_matrix_1, presence: true, if: proc { |q| q.page ==  8 }
  validates :emoji_matrix_2, presence: true, if: proc { |q| q.page ==  9 }

  PanaValidationQuestionaryStructure.structure[2].each do |item|
    validates(item, presence: true, if: proc { |q| q.page == 10 })
  end
  validates :page, presence: true
end
