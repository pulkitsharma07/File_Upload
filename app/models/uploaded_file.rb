class UploadedFile < ApplicationRecord
  after_destroy :delete_file

  def delete_file
    File.delete(location)
    puts location + ' File Deleted'
  rescue Errno::ENOENT => error
    p 'File does not exist !!!'
  end
end
