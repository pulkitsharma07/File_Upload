class AddSizeToUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :uploaded_files, :size, :integer
  end
end
