class FilesController < ApplicationController
  before_filter :authorize

  def upload
    upload = params[:upload]
    file_name = upload['datafile'].original_filename if upload['datafile'] != ''
    file = upload['datafile'].read
    save_location = Rails.root.to_s

    File.open(save_location + '/user_data/' + file_name, "wb") do |f|
            f.write(file)
    end

    p "Uploaded : #{file_name}", file.size, current_user
    redirect_to '/'
  end

  def download
  end
end
