class PanaValidationQuestionary < ApplicationRecord
  belongs_to :subject

  # Validate presence for each pair of emojis
  PanaValidationQuestionaryStructure.calculate_vertical_pana_columns.each_with_index do |column, column_index|
    validates(column, presence: true, if: proc { |q| q.page == (column_index + 1) })
  end

  (5..9).each_with_index do |page, index|
    validates("who#{index + 1}", presence: true, if: proc { |q| q.page == page })
  end

  (10..19).each_with_index do |page, index|
    validates("pnv#{index + 1}", presence: true, if: proc { |q| q.page == page })
  end

  (20..24).each_with_index do |page, index|
    validates("swls#{index + 1}", presence: true, if: proc { |q| q.page == page })
  end

  validates :emoji_matrix_1, presence: true, if: proc { |q| q.page ==  25 }
  validates :emoji_matrix_2, presence: true, if: proc { |q| q.page ==  26 }

  validates :page, presence: true
end
