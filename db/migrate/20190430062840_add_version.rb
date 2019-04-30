class AddVersion < ActiveRecord::Migration[5.1]
  def change
    add_column :pana_validation_questionaries, :version, :integer, default: 0
  end
end
