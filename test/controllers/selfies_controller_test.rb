require "test_helper"

class SelfiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @selfy = selfies(:one)
  end

  test "should get index" do
    get selfies_url
    assert_response :success
  end

  test "should get new" do
    get new_selfy_url
    assert_response :success
  end

  test "should create selfy" do
    assert_difference('Selfie.count') do
      post selfies_url, params: { selfy: { description: @selfy.description, title: @selfy.title } }
    end

    assert_redirected_to selfy_url(Selfie.last)
  end

  test "should show selfy" do
    get selfy_url(@selfy)
    assert_response :success
  end

  test "should get edit" do
    get edit_selfy_url(@selfy)
    assert_response :success
  end

  test "should update selfy" do
    patch selfy_url(@selfy), params: { selfy: { description: @selfy.description, title: @selfy.title } }
    assert_redirected_to selfy_url(@selfy)
  end

  test "should destroy selfy" do
    assert_difference('Selfie.count', -1) do
      delete selfy_url(@selfy)
    end

    assert_redirected_to selfies_url
  end
end
