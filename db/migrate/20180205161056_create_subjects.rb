class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.integer :birth_year
      t.string :gender
      t.integer :education
      t.string :residence

      t.timestamps
    end
  end
end
