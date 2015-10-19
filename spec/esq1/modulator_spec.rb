require "spec_helper"

describe ESQ1::Modulator do

  before :all do
    @modulator = ESQ1::Modulator.new
  end

  subject { @modulator }
  it { should respond_to :source }
  it { should respond_to :amount }

  it "initializes with default values" do
    expect(@modulator).to be_an(ESQ1::Modulator)
    expect(@modulator.source).to eq(15)
    expect(@modulator.amount).to eq(0)
  end

  describe "class constants" do
    it "SOURCES should return an array of mod sources" do
      expect(ESQ1::Modulator::SOURCES).to be_an(Array)
      expect(ESQ1::Modulator::SOURCES.length).to eq(16)
    end
  end

  describe "building up to X modulators" do

    it "fills in empty modulators" do
      empty_modulators = []

      built_modulators = ESQ1::Modulator.build_missing(total: 2, modulators: empty_modulators)

      expect(built_modulators.length).to eq(2)
      expect(built_modulators.first).to be_a(ESQ1::Modulator)
    end
  end

  it ".source_name looks up the name of the mod source" do
    expect(@modulator.source_name).to match(/OFF/)
  end

  describe ".to_s" do
    before do
      @mod_string = @modulator.to_s
    end

    it "shows the mod source and amount" do
      expect(@mod_string).to eq("#{ @modulator.source_name }: #{ @modulator.amount }")
    end
  end

end
