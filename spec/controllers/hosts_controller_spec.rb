require "spec_helper.rb"

describe HostController do
    login user

    def valid_attributes
      {
          :id => 1,
          :created_on => "2012-05-5",
          :expires_on => "2013-05-6",
          :user_type => "Customer",
          :name_of_client => "someName",
          :place => "Bangalore",
          :email_id => "somecompany@gmail.com",
          :access_url => "http://www.somecompany.co.in",
          :ftp_host => "ftp.paycalci.com",
          :ftp_user => "common",
          :ftp_password => "279249918",
          :ftp_quota => "someQuota",
          :db_name => "_paycalci_someName",
          :db_host => "someHost",
          :db_user => "paycalci_common",
          :db_password => "348104511",
          :pdf_file_name => "UploadCheck",
          :pdf_content_type => "application/pdf",
          :pdf_file_size => 12365
      }
    end

end