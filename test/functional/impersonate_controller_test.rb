require 'test_helper'

class TinderfieldsUserImpersonate::ImpersonateControllerTest < ActionController::TestCase
  test 'index should require authentication' do
    get :index, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/users/sign_in'
  end

  test 'create should require authentication' do
    get :create, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/users/sign_in'
  end

  test 'destroy should not require authentication' do
    delete :destroy, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/'
  end

  test 'configuration uses default model User' do
    user = mock('User')

    @controller.expects(:config_or_default).
      with(:authenticate_user_method, 'authenticate_user!').
      returns('authenticate_user!')
    @controller.expects(:config_or_default).
      with(:current_staff, 'current_user').
      returns('current_user')
    @controller.expects(:config_or_default).
      with(:user_is_staff_method, 'staff?').
      returns('staff?')

    @controller.expects(:authenticate_user!).once.returns(true)
    @controller.expects(:current_user).once.returns(user)
    @controller.expects(:authenticate_admin_user!).never
    @controller.expects(:current_admin_user).never

    get :index, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/'
    assert_equal user, assigns(:current_staff)
  end

  test 'configuration to use a different model than User' do
    admin_user = mock('AdminUser')

    @controller.expects(:config_or_default).
      with(:authenticate_user_method, 'authenticate_user!').
      returns('authenticate_admin_user!')
    @controller.expects(:config_or_default).
      with(:current_staff, 'current_user').
      returns('current_admin_user')
    @controller.expects(:config_or_default).
      with(:user_is_staff_method, 'staff?').
      returns('staff?')

    @controller.expects(:authenticate_user!).never
    @controller.expects(:current_user).never
    @controller.expects(:authenticate_admin_user!).once.returns(true)
    @controller.expects(:current_admin_user).once.returns(admin_user)

    get :index, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/'
    assert_equal admin_user, assigns(:current_staff)
  end

  # https://github.com/rcook/user_impersonate2/issues/3
  # If config.staff_finder is not specified, default of "find" should be used.
  # Similarly, config.staff_class should default to "User".
  test 'staff_finder not specified' do
    options = TinderfieldsUserImpersonate::Engine.config.class.class_variable_get('@@options')
    options.delete(:staff_class)
    options.delete(:staff_finder)
    user = User.create!(:email => 'test@example.com', :password => 'password')
    session[:staff_user_id] = user.id
    staff_user = @controller.view_context.current_staff_user
    assert_equal user, staff_user
  end

  # https://github.com/rcook/user_impersonate2/issues/3
  # If config.staff_finder is nil, default of "find" should be used.
  # Similarly, config.staff_class should default to "User".
  test 'staff_finder nil' do
    options = TinderfieldsUserImpersonate::Engine.config.class.class_variable_get('@@options')
    options[:staff_class] = nil
    options[:staff_finder] = nil
    user = User.create!(:email => 'test@example.com', :password => 'password')
    session[:staff_user_id] = user.id
    staff_user = @controller.view_context.current_staff_user
    assert_equal user, staff_user
  end

  # https://github.com/rcook/user_impersonate2/issues/3
  # If config.staff_finder is specified, the given method should be called.
  test 'staff_finder other' do
    options = TinderfieldsUserImpersonate::Engine.config.class.class_variable_get('@@options')
    options[:staff_finder] = :other
    user = User.create!(:email => 'test@example.com', :password => 'password')
    session[:staff_user_id] = user.id
    assert_raises NoMethodError do
      @controller.view_context.current_staff_user
    end
  end

  # https://github.com/rcook/user_impersonate2/issues/3
  # If config.staff_class is specified, the given model should be used.
  test 'staff_class other' do
    options = TinderfieldsUserImpersonate::Engine.config.class.class_variable_get('@@options')
    options[:staff_class] = 'SomeUser'
    user = User.create!(:email => 'test@example.com', :password => 'password')
    session[:staff_user_id] = user.id
    assert_raises NameError do
      @controller.view_context.current_staff_user
    end
  end
end

