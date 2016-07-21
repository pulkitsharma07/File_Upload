class UploadedFile < ApplicationRecord
  after_destroy :delete_file
  belongs_to :user


  def self.upload(current_user, args)
    file_name = args['datafile'].original_filename if args['datafile'] != ''
    file = args['datafile'].read
    save_location = Rails.root.to_s + '/user_data'

    Dir.mkdir(save_location) unless File.directory?(save_location)

    new_file_name = Digest::MD5.hexdigest(current_user.password_digest + file_name + Time.now.to_s)

    File.open(save_location + '/' + new_file_name, "wb") do |f|
            f.write(file)
    end

    current_user.uploaded_files << UploadedFile.new(name: file_name, location: save_location + '/' + new_file_name, size: file.size)

    p "Uploaded : #{file_name}", file.size, current_user
  end


  def read_file
    File.read(location)
  end

  def delete_file
    File.delete(location)
    puts location + ' File Deleted'
  rescue Errno::ENOENT => error
    p 'File does not exist !!!'
  end
end
