require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path

    assert_no_difference "User.count" do
      post users_path, params: { user: {name: "",
                                        email: "user@invalid",
                                        password: "foobar",
                                        password_confirmation: "footbar"
      } } 
    end
    assert_response :unprocessable_entity
    assert_template :"users/new"
    assert_select "div#error_explanation"
    assert_select "div.alert"
  end


  test "valid signup information" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: {name: "hoge",
                                        email: "user@invali.feifefd",
                                        password: "12345678",
                                        password_confirmation: "12345678"
      } }
    end
    follow_redirect!
    assert_template :"users/show"
    assert_not flash.empty?
    assert is_logged_in?
  end
end
