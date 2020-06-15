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

    describe "#challenge" do
        it "should record the loss of the challenging player if the fragment is valid" do
            game.fragment = "adrif"
            expect(game.challenge).to be(game.rec_loss(game.current_player))
        end

        it "should print 'you lost this round' to the challenging player" do
            expect { game.challenge }.to output(/you lost this round/).to_stdout
        end

        it "should record the loss of the challenged player if the fragment is invalid" do
            game.fragment = "adkjf"
            expect(game.challenge).to be(game.rec_loss(game.previous_player))
        end

        it "should print 'you lost this round' to the challenged player" do
            expect { game.challenge }.to output(/you lost this round/).to_stdout
        end
    end

    describe "#round_lost?" do
        it "should return false if the round is not yet lost" do
            game.fragment = "adrif"
            expect(game.round_lost?).to be(false)
        end

        it "should return true if the round is lost" do
            game.fragment = "adrift"
            expect(game.round_lost?).to be(true)
        end
    end

    describe "#reg_loss" do
        it "should record a regular loss" do
            expect(game.reg_loss).to be(game.rec_loss(game.previous_player))
        end

        it "should print 'you lost this round by completing the word, adrift'" do
            game.fragment = "adrift"
            expect { game.reg_loss }.to output(/you lost this round by completing the word, adrift/).to_stdout
        end
    end

    describe "#player_lost?" do
        it "should return false if the player has not lost" do
            expect(game.player_lost?(game.current_player)).to be(false)
        end

        it "should return true if the player has lost" do
            rec = game.instance_variable_get(:@rec)
            player = game.current_player
            rec[player] = "GHOST"
            expect(game.player_lost?(player)).to be(true)
        end
    end

    describe "#game_lost?" do
        it "should return false when the game is not lost" do
            expect(game.game_lost?).to be(false)
        end

        it "should return true when the game is lost" do
            players = game.instance_variable_get(:@players)
            players.pop(3)
            expect(game.game_lost?).to be(true)
        end
    end

    describe "#rec_loss" do
        it "should print 'You now have' up until the player is eliminated" do
            expect { game.rec_loss(game.current_player) }.to output(/You now have/).to_stdout
        end

        it "should print 'Game over' once the player is eliminated" do
            rec = game.instance_variable_get(:@rec)
            player = game.current_player
            rec[player] = "GHOS"
            expect { game.rec_loss(game.current_player) }.to output(/Game over/).to_stdout
        end
    end

