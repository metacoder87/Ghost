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

