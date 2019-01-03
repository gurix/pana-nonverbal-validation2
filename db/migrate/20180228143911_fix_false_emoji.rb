class FixFalseEmoji < ActiveRecord::Migration[5.1]
  def change
    rename_column :pana_validation_questionaries, :PA3_hi__PA4_lo, :PA3_hi__PA3_lo
  end
end
