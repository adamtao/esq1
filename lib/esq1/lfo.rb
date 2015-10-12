require "esq1/modulator"

module ESQ1

  class LFO
    attr_accessor :number,
      :frequency,
      :time1,
      :time2,
      :delay,
      :reset,
      :humanize,
      :wave,
      :modulator

    WAVES = %w(
      TRI
      SAW
      SQU
      NOI
    )

    def initialize(number, opts={})
      @number = number
      @frequency = opts[:frequency] || 0
      @time1 = opts[:time1] || 0
      @time2 = opts[:time2] || 0
      @delay = opts[:delay] || 0
      @reset = opts[:reset] || false
      @humanize = opts[:humanize] || false
      @wave = opts[:wave] || 0
      @modulator = opts[:modulator] || ESQ1::Modulator.new
    end

    def wave_name
      WAVES[self.wave]
    end

  end

end
