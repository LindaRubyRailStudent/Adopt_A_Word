require 'test_helper'

class WordiesControllerTest < ActionController::TestCase
  setup do
    @wordy = wordies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wordies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wordy" do
    assert_difference('Wordy.count') do
      post :create, wordy: @wordy.attributes
    end

    assert_redirected_to wordy_path(assigns(:wordy))
  end

  test "should show wordy" do
    get :show, id: @wordy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wordy.to_param
    assert_response :success
  end

  test "should update wordy" do
    put :update, id: @wordy.to_param, wordy: @wordy.attributes
    assert_redirected_to wordy_path(assigns(:wordy))
  end

  test "should destroy wordy" do
    assert_difference('Wordy.count', -1) do
      delete :destroy, id: @wordy.to_param
    end

    assert_redirected_to wordies_path
  end
end
