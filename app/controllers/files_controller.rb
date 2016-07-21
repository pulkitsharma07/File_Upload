class FilesController < ApplicationController
  before_filter :authorize
  before_action :current_file, except: [:upload]

  def upload
    if params[:upload].nil?
      redirect_to '/', flash: {error: "Please select a file"}
      return
    end

    UploadedFile.upload(current_user, params[:upload])

    redirect_to '/'
  end

  def download
    send_data @file.read_file, disposition: 'attachment', filename: @file.name
  end

  def delete
    @file.destroy
    redirect_to '/'
  end

  private

  def current_file
    @file ||= current_user.uploaded_files.find(params[:file_id])
  rescue
    redirect_to '/', flash: {error: "Invalid File"}
  end
end
