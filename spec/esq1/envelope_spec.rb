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
end
