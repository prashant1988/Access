class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.date :created_on
      t.date :expire_on
      t.string :user_type
      t.string :client
      t.string :place
      t.string :email
      t.string:access_url
      t.string:ftp_host
      t.string:ftp_user
      t.string:ftp_password
      t.string:ftp_quote
      t.string:db_host
      t.string:db_name
      t.string:db_password
      t.string:db_user

      t.timestamps
    end
  end
end
