require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # test "layout links" do
  #   get root_path
  #   assert_template 'static_pages/home'
  #   assert_select "a[href=?]", root_path, count: 2
  #   assert_select "a[href=?]", help_path
  #   assert_select "a[href=?]", about_path
  #   assert_select "a[href=?]", contact_path
  #   assert_select "a[href=?]", signup_path
    
  #   get contact_path
  #   assert_select "title", full_title("Contact")

  #   get signup_path
  #   assert_select "title", full_title("Sign up")
  # end
  
  test "layout links login" do

    log_in_as(@user)

    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", login_path, count: 0
    # 追加: フォロー/フォロワーリンクの存在確認
    assert_select 'a[href=?]', following_user_path(@user)
    assert_select 'a[href=?]', followers_user_path(@user)
  end

  test "layout links when not logged in" do
    get root_path
    assert_template 'static_pages/home'
    # 共通リンク
    assert_select "a[href=?]", root_path, count: 2  # ロゴと Home
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    # ログインしていないならこれらのリンクがある
    assert_select "a[href=?]", login_path
    # ログインしていないなら logout や profile へのリンクはない
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
