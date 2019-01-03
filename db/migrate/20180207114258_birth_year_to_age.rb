class BirthYearToAge < ActiveRecord::Migration[5.1]
  def change
    rename_column :subjects, :birth_year, :age
  end
end
