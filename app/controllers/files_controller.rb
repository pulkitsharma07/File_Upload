class FilesController < ApplicationController
  before_filter :authorize

  def upload
    if params[:upload].nil?
      redirect_to '/',flash: {error: "Please select a file"}
      return
    end
    upload = params[:upload]
    file_name = upload['datafile'].original_filename if upload['datafile'] != ''
    file = upload['datafile'].read
    save_location = Rails.root.to_s + '/user_data'

    Dir.mkdir(save_location) unless File.directory?(save_location)

    new_file_name = Digest::MD5.hexdigest(current_user.password_digest + file_name + Time.now.to_s)

    File.open(save_location + '/' + new_file_name, "wb") do |f|
            f.write(file)
    end

    current_user.uploaded_files << UploadedFile.new(name: file_name, location: save_location + '/' + new_file_name)

    p "Uploaded : #{file_name}", file.size, current_user
    redirect_to '/'
  end

  def download
    file = current_file

    p " Downloading ", file.inspect

    data = File.read(file.location)

    send_data data, disposition: 'attachment',filename: file.name
  end

  def delete
    file = current_file
    file.destroy
    redirect_to '/'
  end

  private

  def current_file
    UploadedFile.find(params[:file_id])
  end
end
