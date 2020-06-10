            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost


class Player

    attr_accessor :player_name

    def initialize(player_name)
        @player_name = player_name
    end

    def get_guess
        puts "#{@player_name} take a guess..."
        gets.chomp.to_s
    end 

end