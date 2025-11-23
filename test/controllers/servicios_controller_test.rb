require "test_helper"

class ServiciosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servicios_index_url
    assert_response :success
  end
end
