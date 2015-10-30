module ESQ1

  class Modulator
    attr_accessor :source, :amount

    SOURCES = %w(
      LFO1
      LFO2
      LFO3
      ENV1
      ENV2
      ENV3
      ENV4
      VEL
      VEL2
      KYBD
      KYBD2
      WHEEL
      PEDAL
      XCTRL
      PRESS
      *OFF*
    )

    def initialize(opts={})
      @source = opts.fetch :source, SOURCES.length - 1
      @amount = opts.fetch :amount, 0
    end

    def to_s
      "#{ source_name }: #{ amount }"
    end

    def to_h
      {
        "source" => source,
        "source_name" => source_name,
        "amount" => amount
      }
    end

    # Builds a number of Modulators based on provided input:
    #  build_missing(total: TOTAL_NUM_NEEDED, modulators: ARRAY_OF_MODULATORS_ALREADY_INITIALIZED)
    #
    # Returns an Array of Modulators
    #
    def self.build_missing(opts={})
      total = opts.fetch :total, 1
      existing = opts.fetch :modulators, Array.new(total)

      m = Array.new(total)
      m.each_with_index do |item, i|
        if existing[i] && existing[i].is_a?(ESQ1::Modulator)
          m[i] = existing[i]
        else
          m[i] = ESQ1::Modulator.new
        end
      end
      m
    end

    def source_name
      SOURCES[self.source]
    end
  end

end
