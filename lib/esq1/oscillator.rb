require "esq1/dca"
require "esq1/modulator"

module ESQ1

  class Oscillator
    attr_accessor :number, :wave, :octave, :semitone, :fine, :modulators, :dca
    attr_accessor :patch # the patch this oscillator belongs to

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
      @wave = opts.fetch :wave, 0
      @octave = opts.fetch :octave, 0
      @semitone = opts.fetch :semitone, 0
      @fine = opts.fetch :fine, 0
      @dca = opts.fetch :dca, ESQ1::DCA.new(@number, oscillator: self)

      @modulators = initialize_modulators(opts[:modulators])
      @patch = opts[:patch]
    end

    def to_s
      parts = []
      parts << "Wave: #{ wave_name }"
      parts << "Octave: #{ octave }"
      parts << "Semitone: #{ semitone }"
      parts << "Fine: #{ fine }"
      parts << "Modulators: #{ modulators.map{|m| m.to_s }.join(', ')}"
      parts.join(", ")
    end

    def to_h(options={})
      h = {
        "wave" => wave,
        "wave_name" => wave_name,
        "octave" => octave,
        "semitone" => semitone,
        "fine" => fine
      }
      modulators.each_with_index do |m,i|
        m.to_h.each do |k,v|
          h["modulation_#{ k }_#{ i + 1 }"] = v
        end
      end
      h
    end

    def initialize_modulators(modulators)
      modulators ||= []
      ESQ1::Modulator.build_missing(total: 2, modulators: modulators)
    end

    def wave_name
      WAVES[self.wave]
    end

  end

end
