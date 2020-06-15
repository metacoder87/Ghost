            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost


require 'game'
require 'player'
require 'arti'

describe "Game" do
  let(:game) { Game.new("player_1", "player_2", "ai_3", "arti_4") }

    describe "#initialize" do
      it "should accept any number of players" do
        game
      end

      it "should set @players to an array of instances of Player::new & Arti::new" do
        players = game.instance_variable_get(:@players)
        expect(players[0]).to be_instance_of(Player)
        expect(players[2]).to be_instance_of(Arti)
      end

      it "should set @fragment to an empty string" do
        frag = game.instance_variable_get(:@fragment)
        expect(frag).to eq("")
      end

      it "should set @dictionary to txt file stored in a Set" do
        dictionary = game.instance_variable_get(:@dictionary)
        expect(dictionary).to be_instance_of(Set)
      end

      it "should set @rec to an empty hash" do
        rec = game.instance_variable_get(:@rec)
        expect(rec).to be_instance_of(Hash)
      end

    end

    describe "#current_player" do
        it "should set current_player to the first player in @players" do
            expect(game.current_player.player_name).to eq("player_1")
        end
    end

    describe "#previous_player" do
        it "should set previous_player to the last player in @players" do
            expect(game.previous_player.player_name).to eq("arti_4")
        end
    end

    describe "#next_player" do
        it "should switch to the second player in the queue" do
            players = game.instance_variable_get(:@players)
            game.next_player
            expect(game.current_player.player_name).to eq("player_2")
        end
    end

    describe "#take_turn" do
        # it "should print 'take a guess...'" do
        #     input = "x"
        #     allow(game).to receive(:gets).and_return(input)
        #     expect { game.take_turn(game.current_player) }.to output(/take a guess.../).to_stdout
        # end
    end

    describe "#valid_play?" do
        it "should return true when given a single letter of the alphabet" do
            expect(game.valid_play?("z")).to be(true)
            expect(game.valid_play?("v")).to be(true)
            expect(game.valid_play?("g")).to be(true)
        end

        it "should return false when anything else is input" do
            expect(game.valid_play?("ab")).to be(false)
            expect(game.valid_play?("1")).to be(false)
            expect(game.valid_play?("&i5")).to be(false)
        end

        it "should recognize Challenge as a valid command" do
            expect(game.valid_play?("challenge")).to be(true)
        end
    end

    describe "#fragment_matches" do
        it "should return an array of words that match the fragment" do
            game.fragment = "adrif"
            expect(game.fragment_matches).to eq(["adrift"])
        end
    end

    describe "#valid_frag?" do
        it "should return true as long as there are fragment_matches" do
            game.fragment = "adrif"
            expect(game.valid_frag?).to be(true)
        end

        it "should return false when there are no fragment_matches" do
            game.fragment = "zjt"
            expect(game.valid_frag?).to be(false)
        end

    end
