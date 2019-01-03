class AddTicToSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :tic, :string
  end
end
