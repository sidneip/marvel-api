require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  def setup
    @character = Character.create(
      name: 'Abc',
      description: 'teste',
    )
  end

  def test_instanciate_character
    assert_instance_of Character, @character
  end

  def test_character_has_name
    assert_respond_to @character, :name
  end

  def test_character_has_name
    assert_respond_to @character, :description
  end

end
