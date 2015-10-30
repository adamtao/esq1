require "spec_helper"

describe ESQ1::Filter do

  before :all do
    @filter = ESQ1::Filter.new
  end

  subject { @filter }
  it { should respond_to(:cutoff) }
  it { should respond_to(:resonance) }
  it { should respond_to(:keyboard_tracking) }
  it { should respond_to(:modulators) }

  it "initializes with default values" do
    expect(@filter).to be_a(ESQ1::Filter)
    expect(@filter.cutoff).to eq(127)
    expect(@filter.resonance).to eq(0)
    expect(@filter.keyboard_tracking).to eq(15)
    expect(@filter.modulators.length).to eq(2)
  end

  describe ".initialize_modulators" do
    it "builds two empty modulators" do
      modulators = @filter.initialize_modulators([])

      expect(modulators.length).to eq(2)
      expect(modulators.first).to be_a(ESQ1::Modulator)
      expect(modulators.last).to be_a(ESQ1::Modulator)
    end
  end

  describe ".to_s" do
    before do
      @filter_string = @filter.to_s
    end

    it "should show the values" do
      expect(@filter_string).to match("Cutoff: #{ @filter.cutoff }")
      expect(@filter_string).to match("Resonance: #{ @filter.resonance }")
      expect(@filter_string).to match("Key Track: #{ @filter.keyboard_tracking }")
      expect(@filter_string).to include("Modulators: #{ @filter.modulators.map{|m| m.to_s }.join(', ')}")
    end
  end

  describe ".to_h should generate a flat hash of parameters" do
    before do
      @h = @filter.to_h
      @keys = @h.keys
    end

    it "has these parameters" do
      expect(@keys).to include("cutoff")
      expect(@keys).to include("resonance")
      expect(@keys).to include("keyboard_tracking")
      expect(@keys).to include("modulation_source_1")
      expect(@keys).to include("modulation_amount_1")
      expect(@keys).to include("modulation_source_2")
      expect(@keys).to include("modulation_amount_2")
    end
  end
end
