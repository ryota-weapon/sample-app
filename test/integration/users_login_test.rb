require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael) 
  end
  
  test "user can log in " do 
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: {
      email: "hogehoge@feij.com", password: "ofejfio"
    }}
    assert_response :unprocessable_entity
    assert_template "sessions/new"
    assert_not flash.empty?  
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    post login_path, params: { session: { email:    @user.email,
    password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)    

    # logout
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @user.email,
    password: "invalid" } }
    assert_response :unprocessable_entity
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    post login_path, params: { session: { email:    @user.email,
    password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)    

    # logout
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "should still work after logout in second window" do 
    delete logout_path
    assert_redirected_to root_url
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember ,'')
  end


  test "login with remembering" do
    log_in_as(@user, remember_me: "1")
    assert_not cookies[:remember_token].blank?
  end
  
  test "login without remembering" do
    log_in_as(@user, remember_me: "1")
    log_in_as(@user, remember_me: "0")
    assert cookies[:remember_token].blank?
  end


end
