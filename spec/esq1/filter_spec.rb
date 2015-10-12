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
end