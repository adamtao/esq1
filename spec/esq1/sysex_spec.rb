require 'spec_helper'

describe ESQ1::Sysex do

  before :all do
    file = File.expand_path('spec/fixtures') + '/BASIC.syx'
    sysex_data = File.open(file, 'rb').read
    @sysex = ESQ1::Sysex.new( sysex_data )
  end

  it "should initialize" do
    expect(@sysex).to be_a(ESQ1::Sysex)
  end

  describe "reading a single-patch file" do

    before do
      @patch = @sysex.patches.first
    end

    it "should read a file into a patch" do
      expect(@patch).to be_a(ESQ1::Patch)
      expect(@patch.name).to match(/BASIC/)
    end

    it "should read envelope1 data into the patch" do
      env1 = @patch.envelopes[0]
      expect(env1.level1).to eq(-6)
      expect(env1.level2).to eq(0)
      expect(env1.level3).to eq(0)
      expect(env1.time1).to eq(0)
      expect(env1.time2).to eq(6)
      expect(env1.time3).to eq(63)
      expect(env1.time4).to eq(20)
      expect(env1.velocity_level).to eq(63)
      expect(env1.velocity_attack).to eq(0)
      expect(env1.keyboard_scaling).to eq(9)
    end

    it "should read lfo1 data into the patch" do
      lfo1 = @patch.lfos[0]
      expect(lfo1.wave_name).to match(/TRI/i)
      expect(lfo1.frequency).to eq(21)
      expect(lfo1.level1).to eq(0)
      expect(lfo1.level2).to eq(21)
      expect(lfo1.modulator.source).to eq(11)
      expect(lfo1.reset).to be(false)
      expect(lfo1.humanize).to be(true)
      expect(lfo1.delay).to eq(0)
    end

    it "should read oscillator1 data into the patch" do
      osc1 = @patch.oscillators[0]
      expect(osc1.octave).to eq(0)
      expect(osc1.fine).to eq(0)
      expect(osc1.modulators.last.source).to eq(15)
      expect(osc1.modulators.first.source).to eq(0)
      expect(osc1.modulators.last.amount).to eq(0)
      expect(osc1.modulators.first.amount).to eq(5)
      expect(osc1.wave).to eq(0)
      dca = osc1.dca
      expect(dca.on).to be(true)
      expect(dca.level).to eq(63)
      expect(dca.modulators.last.source).to eq(0)
      expect(dca.modulators.first.source).to eq(15)
      expect(dca.modulators.last.amount).to eq(0)
      expect(dca.modulators.first.amount).to eq(0)
    end

    it "should read dca4 data into the patch" do
      dca4 = @patch.dca4
      expect(dca4.modulators.first.amount).to eq(63)
      expect(dca4.pan).to eq(8)
      expect(dca4.modulators.last.source).to eq(15)
      expect(dca4.modulators.last.amount).to eq(0)
    end

    it "should read filter data into the patch" do
      filter = @patch.filter
      expect(filter.cutoff).to eq(100)
      expect(filter.resonance).to eq(0)
      expect(filter.modulators.first.source).to eq(5)
      expect(filter.modulators.last.source).to eq(0)
      expect(filter.modulators.first.amount).to eq(0)
      expect(filter.modulators.last.amount).to eq(0)
      expect(filter.keyboard_tracking).to eq(0)
    end

    it "should read misc settings data into the patch" do
      mode = @patch.mode
      expect(mode.amplitude_modulation).to be(false)
      expect(mode.oscillator_sync).to be(false)
      expect(mode.voice_restart).to be(true)
      expect(mode.mono).to be(false)
      expect(mode.envelope_restart).to be(false)
      expect(mode.oscillator_restart).to be(false)
      expect(mode.glide).to eq(0)
      expect(mode.envelope_full_cycle).to be(false)
    end
  end

end
