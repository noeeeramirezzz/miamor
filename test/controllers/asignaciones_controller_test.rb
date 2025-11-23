require "test_helper"

class AsignacionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asignaciones_index_url
    assert_response :success
  end
end
