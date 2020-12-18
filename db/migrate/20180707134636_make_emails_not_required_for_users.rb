class MakeEmailsNotRequiredForUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_column :users, :email, :string, null: true
  end

  def self.down
    change_column :users, :email, :string, null: false
  end
end
