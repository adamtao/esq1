require "spec_helper"

describe ESQ1::Patch do

  before :all do
    @patch = ESQ1::Patch.new
  end

  subject { @patch }
  it { should respond_to :name }
  it { should respond_to :oscillators }
  it { should respond_to :filter }
  it { should respond_to :lfos }
  it { should respond_to :envelopes }
  it { should respond_to :dca4 } # Final DCA4 output
  it { should respond_to :mode }

  it "initializes with default values" do
    expect(@patch).to be_an(ESQ1::Patch)
    expect(@patch.name).to be_a(String)
    expect(@patch.oscillators.length).to eq(3)
    expect(@patch.filter).to be_a(ESQ1::Filter)
    expect(@patch.lfos.length).to eq(3)
    expect(@patch.envelopes.length).to eq(4)
    expect(@patch.mode).to be_a(ESQ1::Mode)
    expect(@patch.dca4).to be_a(ESQ1::DCA)
  end

  describe "oscillators" do
    it "should be an Oscillator" do
      expect(@patch.oscillators.first).to be_an(ESQ1::Oscillator)
    end

    it "should reference back to the patch" do
      expect(@patch.oscillators[0].patch).to eq(@patch)
    end
  end

  describe "LFOs" do
    it "should be an LFO" do
      expect(@patch.lfos.first).to be_an(ESQ1::LFO)
    end

    it "should reference back to the patch" do
      expect(@patch.lfos.first.patch).to eq(@patch)
    end
  end

  describe "envelopes" do
    it "should be an Envelope" do
      expect(@patch.envelopes.first).to be_an(ESQ1::Envelope)
    end

    it "should reference back to the patch" do
      expect(@patch.envelopes.first.patch).to eq(@patch)
    end
  end

  describe "DCAs" do
    describe "DCA4" do
      it "should be hardwired to ENV4" do
        expect(@patch.dca4.modulators.first.source_name).to eq("ENV4")
      end

      it "should have pan and pan modulation" do
        expect(@patch.dca4.pan).to be_an(Integer)
        expect(@patch.dca4.modulators.length).to eq(2)
      end

      it "wont have level or 'on' like other DCAs" do
        expect(@patch.dca4.level).to be(nil)
        expect(@patch.dca4.on).to be(nil)
      end

      it "should relate back to the patch" do
        expect(@patch.dca4.patch).to eq(@patch)
      end
    end
  end

  describe ".to_s" do
    before do
      @patch_string = @patch.to_s
    end

    it "should show the patch name" do
      expect(@patch_string).to match(@patch.name)
    end

    it "should show the oscillators and DCAs" do
      expect(@patch_string).to match("Oscillators:")
      expect(@patch_string).to include(@patch.oscillators.first.to_s)
      expect(@patch_string).to match("DCAs:")
      expect(@patch_string).to include(@patch.oscillators.last.dca.to_s)
    end

    it "should show the Filter" do
      expect(@patch_string).to match("Filter:")
      expect(@patch_string).to include(@patch.filter.to_s)
    end

    it "should show DCA4" do
      expect(@patch_string).to match("DCA4:")
      expect(@patch_string).to include(@patch.dca4.to_s)
    end

    it "should show the LFOs" do
      expect(@patch_string).to match("LFOs:")
      expect(@patch_string).to include(@patch.lfos.first.to_s)
    end

    it "should show the Envelopes" do
      expect(@patch_string).to match("Envelopes:")
      expect(@patch_string).to match(@patch.envelopes[0].to_s)
    end

    it "should show the Mode" do
      expect(@patch_string).to match("Mode:")
      expect(@patch_string).to match(@patch.mode.to_s)
    end

  end

end
