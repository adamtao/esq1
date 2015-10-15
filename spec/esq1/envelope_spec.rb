require "spec_helper"

describe ESQ1::Envelope do

  before :all do
    @envelope = ESQ1::Envelope.new(1)
  end

  subject { @envelope }
  it { should respond_to :number }
  it { should respond_to :time1 }
  it { should respond_to :level1 }
  it { should respond_to :time2 }
  it { should respond_to :level2 }
  it { should respond_to :time3 }
  it { should respond_to :level3 }
  it { should respond_to :time4 }
  it { should respond_to :velocity_level }
  it { should respond_to :velocity_attack }
  it { should respond_to :keyboard_scaling }
  it { should respond_to :patch }

  it "should initialize with default values" do
    expect(@envelope).to be_an(ESQ1::Envelope)
    expect(@envelope.time1).to eq 0
    expect(@envelope.time2).to eq 0
    expect(@envelope.time3).to eq 0
    expect(@envelope.time4).to eq 0
    expect(@envelope.level1).to eq 63
    expect(@envelope.level2).to eq 63
    expect(@envelope.level3).to eq 63
    expect(@envelope.velocity_level).to eq 0
    expect(@envelope.velocity_attack).to eq 0
    expect(@envelope.keyboard_scaling).to eq 0
  end

  it ".levels should return all 3 levels" do
    expect(@envelope.levels).to be_an(Array)
    expect(@envelope.levels.length).to eq(3)
  end

  it ".levels= should assign levels" do
    @envelope.levels = [1, 2, 3]
    expect(@envelope.level1).to eq(1)
    expect(@envelope.level2).to eq(2)
    expect(@envelope.level3).to eq(3)
  end

  it ".times should return all 4 times" do
    expect(@envelope.times).to be_an(Array)
    expect(@envelope.times.length).to eq(4)
  end

  it ".times= should assign times" do
    @envelope.times = [1, 2, 3, 4]
    expect(@envelope.time1).to eq(1)
    expect(@envelope.time2).to eq(2)
    expect(@envelope.time3).to eq(3)
    expect(@envelope.time4).to eq(4)
  end

  describe "relationships" do
    it ".patch should return the patch this ENV belongs to" do
      patch = ESQ1::Patch.new(envelopes: [@envelope])

      expect(@envelope.patch).to eq(patch)
    end

    it "can initialize with a patch" do
      patch = ESQ1::Patch.new
      envelope = ESQ1::Envelope.new(1, patch: patch)

      expect(envelope.patch).to eq(patch)
    end
  end
end
