require 'test_helper'

class FilesControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get files_upload_url
    assert_response :success
  end

  test "should get download" do
    get files_download_url
    assert_response :success
  end

end
