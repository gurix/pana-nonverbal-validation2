class Subject < ApplicationRecord
  visitable nil, optional: true # set optional https://github.com/ankane/ahoy/issues/276#issuecomment-341974325

  has_one :pana_validation_questionary

  serialize :accept_language

  validates :age, :gender, :education, :residence, :group, presence: true
  validates_numericality_of :age, only_integer: true, greater_than: 10, less_than: 100
end
