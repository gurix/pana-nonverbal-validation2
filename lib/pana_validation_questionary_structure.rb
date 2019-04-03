class PanaValidationQuestionaryStructure
  VERTICAL_MAPING = [
    %w[PA3_lo PA1_hi],
    %w[NA1_lo NA2_hi],
    %w[PA4_lo3 PA4_hi],
    %w[NA3_lo NA3_hi],
    %w[VA2_hi VA2_lo]
  ].freeze

  MATRIX_MAPPING = [
    [%w[NA2_hi PA1_hi], %w[PA3_lo NA1_lo]],
    [%w[NA3_hi PA4_hi], %w[PA4_lo3 NA3_lo]]
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
