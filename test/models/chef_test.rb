require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "john", email: "john@example.com")
  end

  test "chef shoud be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be long" do
    @chef.chefname = "a"*51
    assert_not @chef.valid?
  end

  test "chefname should not be short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email length should be within bounds" do
    @chef.email = "a"*81 + "@example.com"
    assert_not @chef.valid?
  end

  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should ACCEPT valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
    #since we want it to be valid and accept we use assert
  end

  test "email validation should REJECT invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.bane@example, eee@i_am.com foo@ee+aar.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end

end