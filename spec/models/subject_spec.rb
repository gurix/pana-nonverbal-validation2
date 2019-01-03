require 'rails_helper'

describe Subject do
  describe '#age' do
    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_numericality_of(:age).only_integer }
    it { is_expected.to validate_numericality_of(:age).is_less_than(100) }
    it { is_expected.to validate_numericality_of(:age).is_greater_than(10) }
  end

  describe '#gender' do
    it { is_expected.to validate_presence_of(:gender) }
  end

  describe '#education' do
    it { is_expected.to validate_presence_of(:education) }
  end

  describe '#residence' do
    it { is_expected.to validate_presence_of(:residence) }
  end
end
