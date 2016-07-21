class FilesController < ApplicationController
  before_filter :authorize

  def upload
    if params[:upload].nil?
      redirect_to '/', flash: {error: "Please select a file"}
      return
    end

    UploadedFile.upload(current_user, params[:upload])

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
