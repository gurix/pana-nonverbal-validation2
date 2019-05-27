class AddSam < ActiveRecord::Migration[5.1]
  def change
    add_column :pana_validation_questionaries, :sam1, :integer
    add_column :pana_validation_questionaries, :sam2, :integer
    add_column :pana_validation_questionaries, :sam3, :integer
  end
end
