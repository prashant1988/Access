class AddAttachHosts < ActiveRecord::Migration
  def change
    add_column  :hosts, :pdf, :has_attached_file
  end


end
