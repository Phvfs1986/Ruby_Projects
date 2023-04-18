# frozen_string_literal: true

require 'yaml'

module SaveLoad
  def save_game
    File.open('board.yaml', 'w') do |file|
      file.write(YAML.dump(Board))
    end
    File.open('game.yaml', 'w') do |file|
      file.write(YAML.dump(Game))
    end
    File.open('player.yaml', 'w') do |file|
      file.write(YAML.dump(Player))
    end
  end
end
