require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post :create, ticket: { activation: @ticket.activation, company: @ticket.company, computer_num: @ticket.computer_num, email: @ticket.email, existing_os: @ticket.existing_os, interesting_brand: @ticket.interesting_brand, interesting_product: @ticket.interesting_product, name: @ticket.name, office_version: @ticket.office_version, phone: @ticket.phone, title: @ticket.title, updating: @ticket.updating, working: @ticket.working }
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket
    assert_response :success
  end

  test "should update ticket" do
    put :update, id: @ticket, ticket: { activation: @ticket.activation, company: @ticket.company, computer_num: @ticket.computer_num, email: @ticket.email, existing_os: @ticket.existing_os, interesting_brand: @ticket.interesting_brand, interesting_product: @ticket.interesting_product, name: @ticket.name, office_version: @ticket.office_version, phone: @ticket.phone, title: @ticket.title, updating: @ticket.updating, working: @ticket.working }
    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket
    end

    assert_redirected_to tickets_path
  end
end
