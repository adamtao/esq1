require "esq1/modulator"

module ESQ1

  class LFO
    attr_accessor :number,
      :frequency,
      :level1,
      :level2,
      :delay,
      :reset,
      :humanize,
      :wave,
      :modulator
    attr_accessor :patch

    WAVES = %w(
      TRI
      SAW
      SQU
      NOI
    )

    def initialize(number, opts={})
      @number = number
      @frequency = opts.fetch :frequency, 0
      @level1 = opts.fetch :level1, 0
      @level2 = opts.fetch :level2, 0
      @delay = opts.fetch :delay, 0
      @reset = opts.fetch :reset, false
      @humanize = opts.fetch :humanize, false
      @wave = opts.fetch :wave, 0
      @modulator = opts.fetch :modulator, ESQ1::Modulator.new
      @patch = opts[:patch]
    end

    def wave_name
      WAVES[self.wave]
    end

    def to_s
      parts = []
      parts << "Wave: #{ wave_name }"
      parts << "Frequency: #{ frequency }"
      parts << "Levels: #{ level1 }, #{ level2 }"
      parts << "Delay: #{ delay }"
      parts << "Reset: #{ reset }"
      parts << "Humanize: #{ humanize }"
      parts << "Modulator: #{ modulator.source_name }"
      parts.join(', ')
    end

  end

end
