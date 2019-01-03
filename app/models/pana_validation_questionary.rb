class PanaValidationQuestionary < ApplicationRecord
  belongs_to :subject

  # Validate presence for each emoji depending on the group
  PanaValidationQuestionaryStructure::MAPPING.each_key do |group|
    PanaValidationQuestionaryStructure::MAPPING[group].each do |pair|
      column_name = PanaValidationQuestionaryStructure.eomji_column_name(pair)
      validates(column_name, presence: true, if: proc { |q| q.subject.group == group })
    end
  end

  # Validate presence for each item of the rest of the survey
  PanaValidationQuestionaryStructure.structure.each_with_index do |page, page_index|
    page.each do |item|
      validates(item, presence: true, if: proc { |q| q.page == (page_index + 2) })
    end
  end

  validates :page, presence: true
end
