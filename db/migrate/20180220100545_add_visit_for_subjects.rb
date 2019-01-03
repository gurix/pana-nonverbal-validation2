class AddVisitForSubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :visit_id, :integer
  end
end
