            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost


require 'arti'

describe "Arti" do
    let(:arti) { Arti.new("ai_1") }
    let(:game) { Game.new("ai_1") }

    describe "#initialize" do
        it "should accept an ai-player name" do
            arti
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

    describe "#pick_move" do
        it "should pick challenge is no winning move available" do
            expect(arti.pick_move("zjt")).to eq("challenge")
        end

        it "should pick a move based on the available words" do
            expect(arti.pick_move("adrif")).to eq("t")
        end
    end
end


            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/Ghost