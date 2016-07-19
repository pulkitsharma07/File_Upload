class FilesController < ApplicationController
  before_filter :authorize

  def upload
    upload = params[:upload]
    file_name = upload['datafile'].original_filename if upload['datafile'] != ''
    file = upload['datafile'].read
    save_location = Rails.root.to_s + '/user_data'

    Dir.mkdir(save_location) unless File.directory?(save_location)

    new_file_name = Digest::MD5.hexdigest(current_user.password_digest + file_name)

    File.open(save_location + '/' + new_file_name, "wb") do |f|
            f.write(file)
    end

    current_user.uploaded_files << UploadedFile.new(name: file_name, location: save_location + '/' + new_file_name)

    p "Uploaded : #{file_name}", file.size, current_user
    redirect_to '/'
  end

  def download
  end
end
