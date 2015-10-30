require "spec_helper"

describe ESQ1::DCA do

  before :all do
    @dca = ESQ1::DCA.new(1)
  end

  subject { @dca }
  it { should respond_to :on }
  it { should respond_to :level }
  it { should respond_to :modulators }
  it { should respond_to :number } # 1, 2, 3, 4
  it { should respond_to :pan }

  it "initializes with default values" do
    expect(@dca).to be_an(ESQ1::DCA)
    expect(@dca.on).to be(true)
    expect(@dca.level).to eq(63)
    expect(@dca.modulators.length).to eq(2)
  end

  describe ".initialize_modulators" do
    it "builds two empty modulators" do
      modulators = @dca.initialize_modulators([])

      expect(modulators.length).to eq(2)
      expect(modulators.first).to be_a(ESQ1::Modulator)
      expect(modulators.last).to be_a(ESQ1::Modulator)
    end
  end

  describe "DCA4" do
    before do
      @dca4 = ESQ1::DCA.new(4)
    end

    it "hardwires its first mod source to ENV4" do
      expect(@dca4.modulators.first.source_name).to eq "ENV4"
    end

    it "initializes the pan setting" do
      expect(@dca4.pan).to eq(8)
    end

    it "should initialize with a patch" do
      patch = ESQ1::Patch.new
      dca4 = ESQ1::DCA.new(4, patch: patch)

      expect(dca4.patch).to eq(patch)
    end

    describe ".to_s" do
      before do
        @dca_string = @dca4.to_s
      end

      it "should show the values" do
        expect(@dca_string).to match("Pan: #{ @dca4.pan }")
        expect(@dca_string).to include("Modulators: #{ @dca4.modulators.map{|m| m.to_s}.join(', ')}")
      end
    end
  end

  describe "not DCA4" do
    it "should initialize with an oscillator" do
      oscillator = ESQ1::Oscillator.new(1)
      dca = ESQ1::DCA.new(1, oscillator: oscillator)

      expect(dca.oscillator).to eq(oscillator)
    end

    it ".on? should return a boolean" do
      expect(@dca.on?).to be(true)
    end

    describe ".to_s" do
      before do
        @dca_string = @dca.to_s
      end

      it "should show the values" do
        expect(@dca_string).to include("Enabled: #{ @dca.on? }")
        expect(@dca_string).to match("Level: #{ @dca.level }")
        expect(@dca_string).to include("Modulators: #{ @dca.modulators.first.to_s }, #{ @dca.modulators.last.to_s }")
      end
    end

    describe ".to_h should generate a flat hash of parameters" do
      before do
        @h = @dca.to_h
        @keys = @h.keys
      end

      it "has these parameters" do
        expect(@keys).to include("on")
        expect(@keys).to include("level")
        expect(@keys).to include("modulation_source_1")
        expect(@keys).to include("modulation_amount_1")
        expect(@keys).to include("modulation_source_2")
        expect(@keys).to include("modulation_amount_2")
      end
    end
  end

end
