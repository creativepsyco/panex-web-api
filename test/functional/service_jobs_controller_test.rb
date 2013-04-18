require 'test_helper'

class ServiceJobsControllerTest < ActionController::TestCase
  setup do
    @service_job = service_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_job" do
    assert_difference('ServiceJob.count') do
      post :create, service_job: {  }
    end

    assert_redirected_to service_job_path(assigns(:service_job))
  end

  test "should show service_job" do
    get :show, id: @service_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_job
    assert_response :success
  end

  test "should update service_job" do
    put :update, id: @service_job, service_job: {  }
    assert_redirected_to service_job_path(assigns(:service_job))
  end

  test "should destroy service_job" do
    assert_difference('ServiceJob.count', -1) do
      delete :destroy, id: @service_job
    end

    assert_redirected_to service_jobs_path
  end
end
