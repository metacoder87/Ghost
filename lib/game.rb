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

    def next_player 
        @players.rotate!
    end

    def valid_play?(command)
        alph = ["challenge"]

        if command.length == 1
            ("a".."z").each { |char| alph << char }
            alph.include?(command)
        elsif command == alph.first
            true
        else false
        end
    end

    def fragment_matches
        matches = []
        @dictionary.each { |word| word[0..@fragment.length-1] == @fragment ? matches << word : word }
        matches
    end
    
    def valid_frag?
        if fragment_matches.count > 0
            true
        else false
        end
    end

    def round_lost?
        matched = []
        @dictionary.each { |word| @fragment == word ? matched << word : word }
        if matched.count == 1
            true
        else false
        end
    end
