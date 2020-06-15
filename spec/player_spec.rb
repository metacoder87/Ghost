            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost


require 'player'

describe "Player" do
    let(:player_1) { Player.new("player_1") }

    describe "#initialize" do
        it "should accept a player name" do
            player_1
        end
    end

    describe "#get_guess" do
        it "gets a guess from the player" do
            input = double(:x, :chomp=>"x")
            allow(player_1).to receive(:gets).and_return(input)

        expect { player_1.get_guess }.to output(/player_1 take a guess.../).to_stdout
        end
    end
end

            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost