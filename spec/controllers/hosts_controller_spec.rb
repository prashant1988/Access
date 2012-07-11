require "spec_helper.rb"

describe HostController do

  include Devise::TestHelpers

  before (:each) do
    @user = User.create(:email=>'p@gmail.com',:password=>'123456')
    sign_in @user
  end

    def valid_attributes
      {
          #:id => 1,
          :created_on => "2012-05-5",
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
          :pdf_file_size => 12365
      }
    end
    def invalid_attributes
      {
          #:id => 1,
          :created_on => "2012-05-5",
          :expire_on => "2012-05-6",
          :user_type => " ",
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
          :pdf_file_size => 12365
      }
    end


  describe "GET Index" do
    it "should have all values from database" do
      host=Host.create!valid_attributes
      get:index
      assigns(:hosts).should eq([host])
    end

    it "should download excel" do
      host=Host.create!valid_attributes
      get:index, :format=> "xls"
    end
  end


  describe "GET new" do
     it "assigns a new value " do
       get:new
       assigns(:host).should be_a_new(Host)
     end
  end

  describe "POST create" do
    it " should create if valid details" do
      post:create, :host=>valid_attributes
      response.should redirect_to(host_index_path)
    end
    it "should not create with invalid details" do
      post:create,  :host=>invalid_attributes
      response.should render_template('new')
    end
  end


  describe "GET show"    do
    it "should have details of any one id"  do
      host=Host.create!valid_attributes
      get:show, :id=>host.id
      assigns(:host).should eq(host)
    end
  end

  describe "GET edit" do
    it "should take updated value" do
      host=Host.create!valid_attributes
      get :edit, :id=>host.id
      response.should render_template('edit')
    end
  end

  describe "PUT update"   do
   it"should have valid update" do
     host=Host.create! valid_attributes
     put:update,:id=>host.id,:host=>valid_attributes
     response.should redirect_to(host_index_path)
   end

    it "should have invalid update " do
      host=Host.create! valid_attributes
      put:update,:id=>host.id, :host=>invalid_attributes
      response.should render_template('edit')
      end
  end

    describe "POST search" do
       it "should found date"  do
      host=Host.create!valid_attributes
      post:search,:id=>host.id,:place=>'Bangalore'
      response.should render_template('search')

       end
    end

  describe " DESTROY delete" do
    it "should delete selected data"do
      host=Host.create!valid_attributes
      delete:destroy,:id=>host.id
      response.should redirect_to(host_index_path)
    end
  end

    #ERROR1. CANNOT READ FILE
  describe "GET Download" do
    it "should download in pdf format" do
      host=Host.create!valid_attributes
      Host.new :pdf_file_name => File.new( Rails.root + 'public/system/hosts/pdfs/000/000/237/original/001280.pdf')
      get:download,:id=>host.id
      #,:files => "/spec/factories/001280.pdf"
      response.should be_success
    end
  end


  describe "GET backup"  do
    it"should gave backup of files" do
      get :backup, :files => "spec/factories/Backup-04-07-2012-15h02m38s.db"
     response.should be_success
    end
  end


  #ERROR 2. RESPONSE
  describe "GET restore backup" do
    it"should restore back_up" do
      #files = fixture_file_upload("/files/Backup-04-07-2012-15h02m38s.db")
      files = File.new(Rails.root + 'public/system/Backup-04-07-2012-15h02m38s.db')
      #class << files
      #  attr_reader :tempfile
      #end
      post:restore_backup, :files=>files
      response.should redirect_to(host_index_path)
    end

  end






end



