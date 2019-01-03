class PanaValidationQuestionariesController < ApplicationController
  RESPONDI_RETURN_CODES = { gj: 917_489, ms: 917_509, sb1: 917_528, sb2: 917_547 }.freeze

  respond_to :html

  before_action :load_subject
  before_action :load_pana_validation_questionary, only: %i[edit update]

  def new
    @pana_validation_questionary = PanaValidationQuestionary.new(subject: @subject)
  end

  def create
    @pana_validation_questionary = PanaValidationQuestionary.new(pana_validation_questionary_params)
    @pana_validation_questionary.subject = @subject
    @pana_validation_questionary.save
    respond_with(@pana_validation_questionary, location: edit_subject_pana_validation_questionary_path(@subject))
  end

  def edit
    @pana_validation_questionary.page += 1
    return observable_redirect_to(respondi_complete_url) if @pana_validation_questionary.page == 8 && @subject.tic.present?
  end

  def update
    @pana_validation_questionary.update_attributes(pana_validation_questionary_params)
    respond_with(@pana_validation_questionary, location: edit_subject_pana_validation_questionary_path(@subject))
  end

  private

  def respondi_complete_url
    "https://mingle.respondi.com/s/#{RESPONDI_RETURN_CODES[@subject.group.to_sym]}/ospe.php3?c_0002=1&return_tic=#{@subject.tic}"
  end

  def pana_validation_questionary_params
    # Whitelist all columns by default
    params.require(:pana_validation_questionary).permit(PanaValidationQuestionary.column_names)
  end

  def load_subject
    @subject = Subject.find(params[:subject_id])
  end

  def load_pana_validation_questionary
    @pana_validation_questionary = @subject.pana_validation_questionary
  end
end
