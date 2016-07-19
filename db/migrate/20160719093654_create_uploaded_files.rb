class CreateUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :uploaded_files do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
