require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create a User with a valid data" do
    user = User.new(uid: 4343243, provider: 'github', name: 'Kelly', email: 'lovely@gmail.com' )
    assert user.save
    assert user.valid?
  end

  test "cannot create a User without email, uid or provider" do
    user = User.new
    assert_not user.save
    assert_includes user.errors, :email
    assert_includes user.errors, :uid
    assert_includes user.errors, :provider
  end

  test "can create two Users with the same provider and different uids" do
    user1 = User.new(uid: 4343243, provider: 'github', name: 'Kelly', email: 'lovely@gmail.com' )
    user2 = User.new(uid: 4343242, provider: 'github', name: 'Kelly', email: 'lovely@gmail.com' )
    assert user1.save
    assert user2.save
    assert user1.valid?
    assert user2.valid?
  end

  test "cannot create two Users with the same provider and the same uid" do
    user1 = User.new(uid: 4343243, provider: 'github', name: 'Kelly', email: 'lovely@gmail.com' )
    user2 = User.new(uid: 4343243, provider: 'github', name: 'Kelly', email: 'lovely@gmail.com' )
    assert user1.save
    assert user1.valid?
    assert_not user2.save
    assert_includes user2.errors, :uid
    assert_not user2.valid?
  end

  test "can create a User based on GitHub's auth_hash" do
    new_user = User.build_from_github(uid: 4343243, "info" => { "name" => "Kelly", "email" => "lovely@gmail.com"} )
    assert new_user.save
    assert new_user.valid?
  end
end
