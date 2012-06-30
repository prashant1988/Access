class Host < ActiveRecord::Base
   attr_accessible :created_on,:expire_on,:user_type,:client,:place,:email,:access_url,:ftp_host,:ftp_user,:ftp_password, :pdf_file_name, :pdf,:pdf_content_type, :pdf_file_size,
  :ftp_quote,:db_name,:db_host,:db_password,:db_user

   has_attached_file :pdf,
                    :styles => { :medium => "50x50>", :thumb => "50x50>",  :small => "150x150>" }



   #validates :created_on,:expire_on,:user_type,:client,:place,:email,:access_url,:ftp_host,:ftp_user,:ftp_password,
           #  :ftp_quote,:db_name,:db_host,:db_password,:db_user,:pdf_file_name , :presence=>'true'
  validate :validate_dates


  def validate_dates
    if self.created_on > self.expire_on
      errors.add(:expire_on,"is invalid ")
    elsif self.expire_on < self.created_on + 1.year
      errors.add(:expire_on,"should be atleast 1 year from created date ")
    end
  end



   def self.back_up
     config = ActiveRecord::Base.configurations[Rails.env]
     latest_dump = "#{Rails.root}/public/system/Backup-#{Time.now.strftime('%d-%m-%Y-%Hh%Mm%Ss')}.db"
       file = File.new(latest_dump, "w")
      system("pg_dump --host=#{config['host']} --port=#{config['port']} --username=#{config['username']} --no-password -Fc #{config['database']} > #{file.path}")

      return file
   end

  def self.restore_db file_path
    drop_all_tables
    config = ActiveRecord::Base.configurations[Rails.env]
    pg_db_restore="pg_restore --host=#{config['host']} --port=#{config['port']} --username=#{config['username']} --no-password -d#{config['database']} #{file_path}"

    system("#{pg_db_restore}")
  end

  def self.drop_all_tables
    conn=ActiveRecord::Base.connection
    tables = conn.execute("SELECT table_name FROM information_schema.tables WHERE table_schema= 'public';").map{|r| r["table_name"]}
    tables.each{|t| conn.execute("DROP TABLE IF EXISTS #{t} CASCADE")}
  end

end
