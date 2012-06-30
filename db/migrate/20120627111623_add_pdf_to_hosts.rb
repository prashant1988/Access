class AddPdfToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :pdf_file_name, :string
    add_column :hosts, :pdf_content_type, :string
    add_column :hosts, :pdf_file_size, :integer

  end
end
