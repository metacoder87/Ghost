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

        def pick_move(fragment)
            $fragment = fragment

            even_matches = []
            odd_matches = []

            even_choices = []
            odd_choices = []

            choice = ""
            safe_i = $fragment.length
            alph = ('a'..'z').collect { |char| char }

            fragment_matches.each { |word| word.length >= safe_i && word.length.odd? ? odd_matches << word : word }
            fragment_matches.each { |word| word.length >= safe_i && word.length.even? ? even_matches << word : word }

            even_matches.each { |word| even_choices << word[safe_i] }
            odd_matches.each { |word| odd_choices << word[safe_i] }

            if $fragment.length == 0
                choice = alph.shuffle.first
            elsif $fragment.length.odd?
                if valid_frag?
                    if odd_matches.count > 0 
                        choice = odd_choices.uniq.first
                    elsif even_matches.count > 0 && odd_choices.uniq.count == 0
                        choice = even_choices.uniq.first
                    end
                else choice = "challenge"
                end
            else
                if valid_frag?
                    
                    if even_matches.count > 0 
                        choice = even_choices.uniq.first
                    elsif odd_matches.count > 0 && even_choices.uniq.count == 0
                        choice = odd_choices.uniq.first
                    end
                else choice = "challenge"
                end
            end
            # puts "Even Matches: #{even_matches}"
            # puts "Even Choices: #{even_choices.uniq}"
            # puts "Odd Matches: #{odd_matches}"
            # puts "Odd Choices: #{odd_choices.uniq}"
            # puts "Choice: #{choice}"
            choice
        end
end