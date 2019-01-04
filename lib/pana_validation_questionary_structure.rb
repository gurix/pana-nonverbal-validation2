class PanaValidationQuestionaryStructure
  MAPPING = {
    'gj' => [
      %w[PA3_lo PA1_hi],
      %w[NA2_lo NA1_hi],
      %w[PA4_hi PA4_lo3],
      %w[VA1_lo NA3_lo],
      %w[VA1_hi VA2_lo]
    ],

    'ms' => [
      %w[PA1_lo PA1_hi],
      %w[NA3_lo NA2_hi],
      %w[PA3_hi PA3_lo],
      %w[NA1_hi NA1_lo],
      %w[VA2_hi VA2_lo]
    ],

    'sb1' => [
      %w[VA1_hi VA1_lo],
      %w[PA1_hi PA1_lo],
      %w[NA1_hi NA1_lo],
      %w[PA2_lo PA2_hi1],
      %w[NA2_lo NA2_hi],
      %w[VA2_lo VA2_hi],
      %w[PA3_lo PA3_hi],
      %w[NA3_lo NA3_hi],
      %w[PA4_hi PA4_lo3],
      %w[NA4_hi NA4_lo]
    ],

    'sb2' => [
      %w[VA1_hi VA1_lo],
      %w[PA1_hi PA1_lo],
      %w[NA1_hi NA1_lo],
      %w[PA2_lo PA2_hi5],
      %w[NA2_lo NA2_hi],
      %w[VA2_lo VA2_hi],
      %w[PA3_lo PA3_hi],
      %w[NA3_lo NA3_hi],
      %w[PA4_hi PA4_lo3],
      %w[NA4_hi NA4_lo]
    ]
  }.freeze

  # Define the structure of the questionary to handle validations and strong parameters automatically
  def self.structure
    [
      [*1..5].map { |i| "who#{i}" },
      [*1..20].map { |i| "mrs#{i}" },
      [*1..10].map { |i| "pnv#{i}" },
      [*1..5].map { |i| "swl#{i}" },
      [*1..3].map { |i| "sam#{i}" },
      [*1..20].map { |i| "pan#{i}" }
    ]
  end

  def self.calculate_emoji_columns
    MAPPING.values.map do |set|
      set.map { |item| eomji_column_name(item) }
    end.flatten.uniq
  end

  def self.eomji_column_name(pair)
    pair.join('__')
  end

  def self.valid_group?(group)
    MAPPING.key? group
  end
end
