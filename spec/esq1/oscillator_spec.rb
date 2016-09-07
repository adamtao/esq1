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
      expect(ESQ1::Oscillator::WAVES.length).to eq(32)
    end
  end

  describe "relationships" do
    it ".patch should return the patch this osc belongs to" do
      patch = ESQ1::Patch.new(oscillators: [@oscillator])

      expect(@oscillator.patch).to eq(patch)
    end

    it "can initialize with a patch" do
      patch = ESQ1::Patch.new
      oscillator = ESQ1::Oscillator.new(1, patch: patch)

      expect(oscillator.patch).to eq(patch)
    end

    it ".dca should relate back to the oscillator" do
      expect(@oscillator.dca.oscillator).to eq(@oscillator)
    end
  end

  describe ".to_s" do
    before do
      @osc_string = @oscillator.to_s
    end

    it "should list the values of the oscillator" do
      expect(@osc_string).to match("Wave: #{@oscillator.wave_name}")
      expect(@osc_string).to match("Octave: #{@oscillator.octave}")
      expect(@osc_string).to match("Semitone: #{@oscillator.semitone}")
      expect(@osc_string).to match("Fine: #{@oscillator.fine}")
      expect(@osc_string).to include("Modulators: #{@oscillator.modulators.first.to_s}, #{@oscillator.modulators.last.to_s}")
    end
  end

  describe ".to_h should generate a flat hash of parameters" do
    before do
      @h = @oscillator.to_h
      @keys = @h.keys
    end

    it "has these parameters" do
      expect(@keys).to include("wave")
      expect(@keys).to include("wave_name")
      expect(@keys).to include("octave")
      expect(@keys).to include("semitone")
      expect(@keys).to include("fine")
      expect(@keys).to include("modulation_source_1")
      expect(@keys).to include("modulation_amount_1")
      expect(@keys).to include("modulation_source_2")
      expect(@keys).to include("modulation_amount_2")
    end
  end

end
