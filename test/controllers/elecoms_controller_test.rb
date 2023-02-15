require "test_helper"

class ElecomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @elecom = elecoms(:one)
  end

  test "should get index" do
    get elecoms_url
    assert_response :success
  end

  test "should get new" do
    get new_elecom_url
    assert_response :success
  end

  test "should create elecom" do
    assert_difference("Elecom.count") do
      post elecoms_url, params: { elecom: { name: @elecom.name, position: @elecom.position } }
    end

    assert_redirected_to elecom_url(Elecom.last)
  end

  test "should show elecom" do
    get elecom_url(@elecom)
    assert_response :success
  end

  test "should get edit" do
    get edit_elecom_url(@elecom)
    assert_response :success
  end

  test "should update elecom" do
    patch elecom_url(@elecom), params: { elecom: { name: @elecom.name, position: @elecom.position } }
    assert_redirected_to elecom_url(@elecom)
  end

  test "should destroy elecom" do
    assert_difference("Elecom.count", -1) do
      delete elecom_url(@elecom)
    end

    assert_redirected_to elecoms_url
  end
end
