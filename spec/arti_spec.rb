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
