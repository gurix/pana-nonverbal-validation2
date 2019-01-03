class AddPan < ActiveRecord::Migration[5.1]
  def change
    20.times { |i| add_column :pana_validation_questionaries, "pan#{i+1}", :integer }
  end
end
