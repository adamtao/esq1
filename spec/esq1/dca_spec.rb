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
  end

end
