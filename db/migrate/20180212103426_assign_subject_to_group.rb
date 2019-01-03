class AssignSubjectToGroup < ActiveRecord::Migration[5.1]
  def change
     add_column :subjects, :group, :string
  end
end
