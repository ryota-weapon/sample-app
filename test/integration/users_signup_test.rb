require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "layout links" do
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
end
