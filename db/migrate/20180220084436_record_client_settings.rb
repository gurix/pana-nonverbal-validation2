class RecordClientSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :user_agent, :string # browser.ua
    add_column :subjects, :accept_language, :text# browser.accept_language.first
  end
end
