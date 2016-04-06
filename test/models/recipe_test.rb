require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup

    #@chef = Chef.new(chefname: "bob", email: "bob@example.com")
    # once association of recipe with chef is made this wont help us because .new is on memory but not in database
    # we should use create to make it be on database
    @chef = Chef.create(chefname: "bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "chicken parm", summary: "Thi is the best chicken parm recipe ever",
             description: "heat oil, add onions, add tomato sauce, add chicken, cook 20 minutes")

    # code below was used to test chef without any associations, was modified above because the relationship of chef and recipes
    #was created
    #
    #@recipe = Recipe.new(name: "chicken parm", summary: "Thi is the best chicken parm recipe ever",
    #         description: "heat oil, add onions, add tomato sauce, add chicken, cook 20 minutes")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "name length should not be too long" do
    @recipe.name = "a" * 51
    assert_not @recipe.valid?
  end

  test "name length should not be too short" do
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end

  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end

  test "summary length should not be too long" do
    @recipe.summary = "z" * 151
    assert_not @recipe.valid?
  end

  test "summary length should not be too short" do
    @recipe.summary = "z" * 9
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description length should not be too long" do
    @recipe.description = "x" * 601
    assert_not @recipe.valid?
  end

  test "description length should not be too short" do
    @recipe.description = "c" * 19
    assert_not @recipe.valid?
  end


end