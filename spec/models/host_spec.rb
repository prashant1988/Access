require 'spec_helper'

describe Host do
  #pending "add some examples to (or delete) #{__FILE__}"

       before{@host=Host.new(:created_on => "2012-05-5",
                           :expire_on => "2013-05-6",
                           :user_type => "Customer",
                           :client => "someName",
                           :place => "Bangalore",
                           :email => "somecompany@gmail.com",
                           :access_url => "http://www.somecompany.co.in",
                           :ftp_host => "ftp.paycalci.com",
                           :ftp_user => "common",
                           :ftp_password => "279249918",
                           :ftp_quote => "someQuota",
                           :db_name => "_paycalci_someName",
                           :db_host => "someHost",
                           :db_user => "paycalci_common",
                           :db_password => "348104511",
                           :pdf_file_name => "UploadCheck",
                           :pdf_content_type => "application/pdf",
                           :pdf_file_size => 12365)}


        subject{ @host }

            it{should respond_to(:created_on)}
            it{should respond_to(:expire_on)}
            it{should respond_to(:user_type)}
            it{should respond_to(:client)}
            it{should respond_to(:place)}
            it{should respond_to(:email)}
            it{should respond_to(:access_url)}
            it{should respond_to(:ftp_host)}
            it{should respond_to(:ftp_user)}
            it{should respond_to(:db_password)}
            it{should respond_to(:pdf_file_name)}
            it{should respond_to(:pdf_content_type)}
            it{should respond_to(:pdf_file_size)}





     #describe "dates should be valid" do
     #  it"should have gap more than 1 year"
     #
     #  before{(@host.created_on+365) <= (@host.expire_on)}
     #  it{ return "true" }
     #
     #end
end
