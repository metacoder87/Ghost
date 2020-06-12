            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost


class Arti

    attr_accessor :player_name

        def initialize(ai_player)
            @player_name = ai_player
            @dictionary = Set.new
                IO.readlines('/Volumes/2tXD Backup/My Stuff/Documents/App Academy Assignments/gary_miller_ghost_project/lib/dictionary.txt').each do |line|
                @dictionary.add(line.chomp)
            end
        end

        def fragment_matches
            matches = []
            @dictionary.each { |word| word[0..$fragment.length - 1] == $fragment ? matches << word : word }
            matches
        end
        
        def valid_frag?
            if fragment_matches.count > 0
                true
            else false
            end
        end

