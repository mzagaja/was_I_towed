class AddAlertTypesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_alert, :boolean, default: false
    add_column :users, :sms_alert, :boolean, default: false
  end
end
