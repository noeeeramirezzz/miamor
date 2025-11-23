require "test_helper"

class DetallesContratosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get detalles_contratos_index_url
    assert_response :success
  end
end
