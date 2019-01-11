class PanaValidationQuestionary < ApplicationRecord
  belongs_to :subject

  # Validate presence for each pair of emojis
  PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each do |column|
    validates(column, presence: true)
  end

  # Validate presence for each item of the rest of the survey
  PanaValidationQuestionaryStructure.structure.each_with_index do |page, page_index|
    page.each do |item|
      validates(item, presence: true, if: proc { |q| q.page == (page_index + 2) })
    end
  end

  validates :page, presence: true
end
