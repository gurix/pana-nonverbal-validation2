class PanaValidationQuestionaryStructure
  VERTICAL_MAPING = [
    %w[PA3_hi PA3_lo],
    %w[PA2_hi1 PA2_lo],
    %w[NA3_hi NA3_lo],
    %w[NA2_hi NA2_lo],
    %w[VA2_hi VA2_lo]
  ].freeze

  MATRIX_MAPPING = [
    [%w[NA2_hi PA2_hi1], %w[PA2_lo NA2_lo]],
    [%w[NA3_hi PA3_hi], %w[PA3_lo NA3_lo]]
  ].freeze

  # Define the structure of the questionary to handle validations and strong parameters automatically
  def self.structure
    [
      [*1..5].map { |i| "who#{i}" },
      [*1..10].map { |i| "pnv#{i}" },
      [*1..5].map { |i| "swls#{i}" }
    ]
  end

  def self.calculate_vertical_pana_columns
    VERTICAL_MAPING.map { |item| eomji_column_name(item) }
  end

  def self.eomji_column_name(pair)
    pair.join('__')
  end
end
