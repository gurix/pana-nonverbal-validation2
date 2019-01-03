class HomeController < ApplicationController
  before_action :assign_group, only: :show

  private

  # If no group is assigned, a random one will be choosen
  def assign_group
    @group = params[:group] || PanaValidationQuestionaryStructure::MAPPING.keys.sample
  end
end
