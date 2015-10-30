require "spec_helper"

describe ESQ1::Mode do

  before :all do
    @mode = ESQ1::Mode.new
  end

  subject { @mode }
  it { should respond_to :oscillator_sync }
  it { should respond_to :amplitude_modulation }
  it { should respond_to :mono }
  it { should respond_to :glide }
  it { should respond_to :voice_restart }
  it { should respond_to :oscillator_restart }
  it { should respond_to :envelope_restart }
  it { should respond_to :envelope_full_cycle }

  it "should initialize with defaults" do
    expect(@mode).to be_a(ESQ1::Mode)
    expect(@mode.oscillator_sync).to be false
    expect(@mode.amplitude_modulation).to be false
    expect(@mode.mono).to be false
    expect(@mode.glide).to be 0
    expect(@mode.voice_restart).to be false
    expect(@mode.oscillator_restart).to be false
    expect(@mode.envelope_restart).to be false
    expect(@mode.envelope_full_cycle).to be false
  end

  describe ".to_s" do
    before do
      @mode_string = @mode.to_s
    end

    it "should show the values" do
      expect(@mode_string).to match("Osc. Sync: #{ @mode.oscillator_sync }")
      expect(@mode_string).to match("AM: #{ @mode.amplitude_modulation }")
      expect(@mode_string).to match("Mono: #{ @mode.mono }")
      expect(@mode_string).to match("Glide: #{ @mode.glide }")
      expect(@mode_string).to match("Voice Restart: #{ @mode.voice_restart }")
      expect(@mode_string).to match("Osc. Restart: #{ @mode.oscillator_restart }")
      expect(@mode_string).to match("Env. Restart: #{ @mode.envelope_restart }")
      expect(@mode_string).to match("Env. Cycle: #{ @mode.envelope_full_cycle }")
    end
  end

  describe ".to_h should generate a flat hash of parameters" do
    before do
      @h = @mode.to_h
      @keys = @h.keys
    end

    it "has these parameters" do
      expect(@keys).to include("oscillator_sync")
      expect(@keys).to include("amplitude_modulation")
      expect(@keys).to include("mono")
      expect(@keys).to include("glide")
      expect(@keys).to include("voice_restart")
      expect(@keys).to include("oscillator_restart")
      expect(@keys).to include("envelope_restart")
      expect(@keys).to include("envelope_full_cycle")
    end
  end
end
