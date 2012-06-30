class HostController < ApplicationController

  before_filter :authenticate_user!

 def index
    @hosts=Host.paginate(:page => params[:page], :per_page => 3).all

    # for Excel ,,,,,, Source------>http://airbladesoftware.com/notes/excel-export
    @host_excel=Host.all
    respond_to do |format|
      format.html
      format.xls do
         render :xls=>@host_excel,
          :columns=>[:created_on,:expire_on,:user_type,:client,:place,:email,:access_url,:ftp_host,:ftp_user,:ftp_password,:ftp_quote,:db_name,:db_host,:db_password,:db_user,:pdf_file_name],
        :headers=> %w[ Created_on Expire_on User_type Client Place Email Access_url Ftp_host Ftp_user Ftp_password Ftp_quote Db_name Db_host Db_password Db_user Pdf_file_name]
      end
    end


  end

  def new
    @host=Host.new
  end

  def create
    @host=Host.new(params[:host])
    if @host.save
      redirect_to :action=>'index'
    else
      render 'new'
    end
  end
 def pswd
 @hostp=Host.new(params[:host])
   u=UUID.new
   @hostp.ftp_password=u.generate[1,7]

   if @hostp.save
     render 'new'
   end
 end

  def show
    @host=Host.find(params[:id])
  end

  def edit
    @host=Host.find(params[:id])
  end

  def update
    @host=Host.find(params[:id])
    if @host.update_attributes(params[:host])
      redirect_to :action=>'index'
     else
      render 'edit'

    end
  end

  def search
   @host=Host.find(:all, :conditions=>['user_type LIKE? OR client LIKE? OR place LIKE? OR email LIKE? OR access_url LIKE? OR ftp_host LIKE? OR ftp_user LIKE? OR ftp_password LIKE? OR db_host LIKE? OR db_name LIKE? OR db_user LIKE?' ,
                         "#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}","#{params[:email]}" ])
   flash[:notice] = "Record found"
  end

  def backup
    file_path=Host.back_up
    puts file_path.inspect
    send_file file_path,
              :filename => File.basename(file_path),
              :type => File.ftype(file_path),
              :disposition => 'attachment'
    FileUtils.rm_r(file_path.path)
  end

 def download
   dwnl=Host.find(params[:id])

   send_file dwnl.pdf.path,
         :filename=>dwnl.pdf_file_name,
         :type=>dwnl.pdf_content_type,
         :disposition=>'attachment'
 flash[:notice]='your file has been downloaded'
 end

  def restore_backup
    tmp=params[:file].tempfile
    file=File.join("#{::Rails.root.to_s}/public/uploaded_files/",params[:file].original_filename)
    FileUtils.cp tmp.path, file
    Host.restore_db file
    FileUtils.remove_file(file, force=true)
    redirect_to :action=>'index'
  end

  def destroy
    @host=Host.find(params[:id])

    if @host.destroy
      redirect_to :action=>'index'
    end
  end

end

def show
  redirect_to user_repo_path(owner_name: @repository.owner_name, repository_name: @repository.name), status: 301 and return if params[:id]

  @build = @repository.builds.last
  if request.format == "image/png"
    send_file Rails.root.join("public/images/#{@build.badge_state}.png"), type: 'image/png', disposition: 'inline'
  else
    authorize! :read, @repository
    if @build
      @active_class_name = "current"
      render 'builds/show' and return
    end
  end
end