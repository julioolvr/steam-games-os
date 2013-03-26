#!/usr/bin/env ruby
require 'json'
require 'httparty'
require 'moneta'
require 'ruby-progressbar'

username = ARGV[0]
user_games_page = HTTParty.get("http://steamcommunity.com/id/#{username}/games?tab=all")

games_json = user_games_page.body.scan(/var rgGames = (.*?);/).flatten.first
game_ids = JSON.parse(games_json).collect {|game| game['appid']}

cache = Moneta.new(:File, dir: 'cache')

windows = 0
osx = 0
linux = 0

progress_bar = ProgressBar.create(total: game_ids.size)

game_ids.each do |id|
  if cache.key?(id)
    game_platforms = cache[id]
  else
    game_page = HTTParty.get("http://store.steampowered.com/app/#{id}")
    game_platforms = {
      windows: game_page.include?('platform_win'),
      osx: game_page.include?('platform_mac'),
      linux: game_page.include?('platform_linux')
    }
    cache[id] = game_platforms
  end

  windows += 1 if game_platforms[:windows]
  osx += 1 if game_platforms[:osx]
  linux += 1 if game_platforms[:linux]

  progress_bar.increment
end

cache.close

puts "RESULTS:"
puts "#{game_ids.size} total games"
puts "#{windows} with Windows support"
puts "#{osx} with OSX support"
puts "#{linux} with Linux support"