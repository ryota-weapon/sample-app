require "test_helper"

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsucceful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user:{
        name: "",
        email: "foo@invalid",
        password: "",
        password_confirmation: ""
      }
    }
    assert_template "users/edit"
    assert_response :unprocessable_entity
  end


  test "succeful edit with friendly forwarding" do
    get edit_user_path(@user) #loginしていないので、before_actionにてloginページに飛ばされる
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert_not has_forwarding? #forwarding_urlが空になっているかチェックする
    name = "new name"
    email = "foob@ar.com"
    patch user_path(@user), params: {
      user:{
        name: name,
        email: email,
        password: "",
        password_confirmation: "" 
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end



end
