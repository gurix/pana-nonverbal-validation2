require 'csv'

class ExportController < ApplicationController
  include ActionController::Live

  before_action :http_basic_auth

  def show
    binding.pry
    csv_header

    Subject.find_each do |subject|
      row = subject_columns.map { |column| subject[column] if subject } +
            pana_validation_questionary_columns.map { |column| subject.pana_validation_questionary[column] if subject.pana_validation_questionary } +
            visit_columns.map { |column| subject.visit[column] if subject.visit }
      response.stream.write CSV.generate_line(row, quote_char: '"')
    end
  ensure
    response.stream.close
  end

  def visit_columns
    Ahoy::Visit.columns.map(&:name) - %w[id user_id]
  end

  def pana_validation_questionary_columns
    PanaValidationQuestionary.columns.map(&:name) - %w[id created_at]
  end

  def subject_columns
    Subject.columns.map(&:name) - %w[visit_id accept_language user_agent updated_at]
  end

  private

  def csv_header
    response.headers['Content-Disposition'] = 'attachment; filename="' + Time.now.strftime('%Y%m%d%H%M') + '.csv"'
    response.headers['Content-Type'] = 'text/csv'
    response.stream.write CSV.generate_line(subject_columns + pana_validation_questionary_columns + visit_columns, quote_char: '"')
  end
end
