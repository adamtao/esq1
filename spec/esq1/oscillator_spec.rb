require "spec_helper"

describe ESQ1::Oscillator do

  before :all do
    @oscillator = ESQ1::Oscillator.new(1)
  end

  subject { @oscillator }
  it { should respond_to :number } # 1, 2, 3
  it { should respond_to :wave }
  it { should respond_to :octave }
  it { should respond_to :semitone }
  it { should respond_to :fine }
  it { should respond_to :modulators }
  it { should respond_to :dca }

  it "initializes with default values" do
    expect(@oscillator).to be_an(ESQ1::Oscillator)
    expect(@oscillator.wave).to eq(0)
    expect(@oscillator.octave).to eq(0)
    expect(@oscillator.semitone).to eq(0)
    expect(@oscillator.fine).to eq(0)
    expect(@oscillator.modulators.length).to eq(2)
    expect(@oscillator.dca).to be_a(ESQ1::DCA)
    expect(@oscillator.dca.number).to eq(@oscillator.number)
  end

  describe ".initialize_modulators" do
    it "builds two empty modulators" do
      modulators = @oscillator.initialize_modulators([])

      expect(modulators.length).to eq(2)
      expect(modulators.first).to be_a(ESQ1::Modulator)
      expect(modulators.last).to be_a(ESQ1::Modulator)
    end
  end

  it ".wave_name should lookup the name" do
    osc = ESQ1::Oscillator.new(wave: 0)
    expect(osc.wave_name).to eq("SAW")
  end

  describe "class constants" do
    it "WAVES should return an array of waves" do
      expect(ESQ1::Oscillator::WAVES).to be_an(Array)
      expect(ESQ1::Oscillator::WAVES.length).to eq(33)
    end
  end

end
