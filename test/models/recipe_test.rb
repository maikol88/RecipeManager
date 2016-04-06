require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @recipe = Recipe.new(name: "chicken parm", summary: "Thi is the best chicken parm recipe ever",
              description: "heat oil, add onions, add tomato sauce, add chicken, cook 20 minutes")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
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