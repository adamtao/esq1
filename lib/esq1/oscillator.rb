require "esq1/dca"
require "esq1/modulator"

module ESQ1

  class Oscillator
    attr_accessor :number, :wave, :octave, :semitone, :fine, :modulators, :dca

    WAVES = %w(
      SAW
      BELL
      SINE
      SQUARE
      PULSE
      NOISE_1
      NOISE_2
      NOISE_3
      BASS
      PIANO
      EL_PNO
      VOICE_1
      VOICE_2
      VOICE_3
      KICK
      REED
      ORGAN
      SYNTH_1
      SYNTH_2
      SYNTH_3
      FORMT_1
      FORMT_2
      FORMT_3
      FORMT_4
      FORMT_5
      PULSE2
      SQR_2
      FOUR_OCTS
      PRIME
      BASS_2
      E_PNO2
      OCTAVE
      OCT_5
    )

    def initialize(number, opts={})
      @number = number
      @wave = opts[:wave] || 0
      @octave = opts[:octave] || 0
      @semitone = opts[:semitone] || 0
      @fine = opts[:fine] || 0
      @modulators = initialize_modulators(opts[:modulators] || [])
      @dca = opts[:dca] || ESQ1::DCA.new(@number)
    end

    def initialize_modulators(modulators=[])
      ESQ1::Modulator.build_missing(total: 2, modulators: modulators)
    end

    def wave_name
      WAVES[self.wave]
    end

  end

end
