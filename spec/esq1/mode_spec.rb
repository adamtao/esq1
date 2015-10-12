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
end
