require "spec_helper"

describe ESQ1::LFO do

  before :all do
    @lfo = ESQ1::LFO.new(1)
  end

  subject { @lfo }
  it { should respond_to :number }
  it { should respond_to :frequency }
  it { should respond_to :time1 }
  it { should respond_to :time2 }
  it { should respond_to :delay }
  it { should respond_to :reset }
  it { should respond_to :humanize }
  it { should respond_to :wave }
  it { should respond_to :modulator }

  it "initializes with default values" do
    expect(@lfo).to be_an(ESQ1::LFO)
    expect(@lfo.frequency).to eq(0)
    expect(@lfo.time1).to eq(0)
    expect(@lfo.time2).to eq(0)
    expect(@lfo.delay).to eq(0)
    expect(@lfo.reset).to be false
    expect(@lfo.humanize).to be false
    expect(@lfo.wave).to eq(0)
    expect(@lfo.modulator).to be_an(ESQ1::Modulator)
  end

  it ".wave_name should lookup the name" do
    lfo = ESQ1::LFO.new(wave: 0)
    expect(lfo.wave_name).to match(/TRI/i)
  end

  describe "class constants" do
    it "WAVES should return an array of waves" do
      expect(ESQ1::LFO::WAVES).to be_an(Array)
      expect(ESQ1::LFO::WAVES.length).to eq(4)
    end
  end

end
