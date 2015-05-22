require 'test_helper'

class EvenimentsControllerTest < ActionController::TestCase
  setup do
    @eveniment = eveniments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eveniments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eveniment" do
    assert_difference('Eveniment.count') do
      post :create, eveniment: { category: @eveniment.category, date: @eveniment.date, description: @eveniment.description, location: @eveniment.location, price: @eveniment.price, timeend: @eveniment.timeend, timestart: @eveniment.timestart, title: @eveniment.title }
    end

    assert_redirected_to eveniment_path(assigns(:eveniment))
  end

  test "should show eveniment" do
    get :show, id: @eveniment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eveniment
    assert_response :success
  end

  test "should update eveniment" do
    patch :update, id: @eveniment, eveniment: { category: @eveniment.category, date: @eveniment.date, description: @eveniment.description, location: @eveniment.location, price: @eveniment.price, timeend: @eveniment.timeend, timestart: @eveniment.timestart, title: @eveniment.title }
    assert_redirected_to eveniment_path(assigns(:eveniment))
  end

  test "should destroy eveniment" do
    assert_difference('Eveniment.count', -1) do
      delete :destroy, id: @eveniment
    end

    assert_redirected_to eveniments_path
  end
end
