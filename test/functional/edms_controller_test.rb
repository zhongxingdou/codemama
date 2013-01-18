require 'test_helper'

class EdmsControllerTest < ActionController::TestCase
  setup do
    @edm = edms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:edms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create edm" do
    assert_difference('Edm.count') do
      post :create, edm: { editing_file: @edm.editing_file, locked: @edm.locked, name: @edm.name, owner_id: @edm.owner_id, template_id: @edm.template_id }
    end

    assert_redirected_to edm_path(assigns(:edm))
  end

  test "should show edm" do
    get :show, id: @edm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @edm
    assert_response :success
  end

  test "should update edm" do
    put :update, id: @edm, edm: { editing_file: @edm.editing_file, locked: @edm.locked, name: @edm.name, owner_id: @edm.owner_id, template_id: @edm.template_id }
    assert_redirected_to edm_path(assigns(:edm))
  end

  test "should destroy edm" do
    assert_difference('Edm.count', -1) do
      delete :destroy, id: @edm
    end

    assert_redirected_to edms_path
  end
end
