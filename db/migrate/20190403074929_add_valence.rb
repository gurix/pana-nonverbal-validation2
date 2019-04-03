class AddValence < ActiveRecord::Migration[5.1]
  def change
    add_column :pana_validation_questionaries, :VA2_hi__VA2_lo, :integer
  end
end
