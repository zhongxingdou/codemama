require 'test_helper'

class EdmTemplatesControllerTest < ActionController::TestCase
  setup do
    @edm_template = edm_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:edm_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create edm_template" do
    assert_difference('EdmTemplate.count') do
      post :create, edm_template: { editingfile: @edm_template.editingfile, locked: @edm_template.locked, name: @edm_template.name, preview: @edm_template.preview }
    end

    assert_redirected_to edm_template_path(assigns(:edm_template))
  end

  test "should show edm_template" do
    get :show, id: @edm_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @edm_template
    assert_response :success
  end

  test "should update edm_template" do
    put :update, id: @edm_template, edm_template: { editingfile: @edm_template.editingfile, locked: @edm_template.locked, name: @edm_template.name, preview: @edm_template.preview }
    assert_redirected_to edm_template_path(assigns(:edm_template))
  end

  test "should destroy edm_template" do
    assert_difference('EdmTemplate.count', -1) do
      delete :destroy, id: @edm_template
    end

    assert_redirected_to edm_templates_path
  end
end
