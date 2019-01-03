class SubjectsController < ApplicationController
  respond_to :html
  after_action :track_creation

  def new
    @subject = Subject.new
    @subject.group = params[:group]
    @subject.tic = params[:tic]
    check_group
  end

  def create
    @subject = Subject.new(subject_params.merge(accept_language: browser.accept_language, user_agent: browser.ua))
    check_group
    location = new_subject_pana_validation_questionary_path(@subject) if @subject.save
    respond_with(@subject, location: location)
  end

  private

  def subject_params
    params.require(:subject).permit(:age, :gender, :education, :residence, :group, :tic)
  end

  # Ensure each subject is in a group and the choosen group is available
  def check_group
    raise 'missing group' unless @subject.group
    raise "#{@subject.group} is not available" unless PanaValidationQuestionaryStructure.valid_group? @subject.group
  end

  def track_creation
    ahoy.track "#{controller_path}##{action_name}", params: request.path_parameters
  end
end
