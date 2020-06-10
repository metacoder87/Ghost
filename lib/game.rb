            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost


require_relative 'player'
            
class Game

    attr_accessor :players, :fragment, :rec, :dictionary

    def initialize(*players)
        @players = []
        players.each { |player| @players << Player.new(player) }
        @fragment = ""
        @dictionary = Set.new
        IO.readlines('/Volumes/2tXD Backup/My Stuff/Documents/App Academy Assignments/gary_miller_ghost_project/lib/dictionary.txt').each do |line|
            @dictionary.add(line.chomp)
        end
        @rec = Hash.new()
        @players.each { |player| @rec[player] = "" }        
    end

    def current_player
        @players.first
    end

    def previous_player
        @players.last
    end

