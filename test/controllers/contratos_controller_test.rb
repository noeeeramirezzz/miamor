require "test_helper"

class ContratosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contratos_index_url
    assert_response :success
  end
end
