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

    def last_player
        @players.rotate!(-1)
    end

    def take_turn(player)
        if round_lost?
            reg_loss
        elsif player_lost?(player)
        elsif game_lost?
        else
            char = current_player.get_guess
            if valid_play?(char)
                if char.length == 1
                    @fragment += char
                    puts @fragment
                else
                    challenge
                end
            else puts "Try entering a single character command from A - Z or challenging your oppenent with the word, challenge."
                last_player
            end
        end
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

    def challenge
        if valid_frag?
            puts "#{current_player.player_name} you lost this round because, #{@fragment}\n 
                    Is building toward the words: #{fragment_matches}"
            rec_loss(current_player)
            next_player
        else 
            puts "#{previous_player.player_name} you lost this round because, #{@fragment}\n 
                    Is not building toward any words and #{current_player.player_name} called you on it."
            rec_loss(previous_player)
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

    def reg_loss
        puts "#{previous_player.player_name} you lost this round by completing the word, #{@fragment}"
        rec_loss(previous_player)
    end

    def player_lost?(player)
        if @rec[player] == "GHOST"
            return true
        else false
        end
    end

    def game_lost?
        if @players.count == 1
            return true
        else false
        end
    end

    def rec_loss(player)
        @rec[player] += ("GHOST".delete @rec[player]).chars.first 
        puts "You now have #{@rec[player]}"
        @fragment.clear
        if player_lost?(player)
            @rec.delete(player)
            @players.delete(player)
            print "Game over,\n #{player.player_name} you are a GHOST...\n"
        end
        last_player
    end

    def play_game
        until game_lost? do
            take_turn(current_player)
            next_player
        end

        while game_lost?
            print "#{current_player.player_name} WON,\n you are the lone survivor...\n"
            break
        end
    end

    game = Game.new('player_1', 'player_2')
    game.take_turn(game.play_game)
end