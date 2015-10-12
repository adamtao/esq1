require "esq1/modulator"

module ESQ1

  class Filter
    attr_accessor :cutoff, :resonance, :keyboard_tracking, :modulators

    def initialize(opts={})
      @cutoff = opts[:cutoff] || 127
      @resonance = opts[:resonance] || 0
      @keyboard_tracking = opts[:keyboard_tracking] || 15
      @modulators = initialize_modulators(opts[:modulators] || [])
    end

    def initialize_modulators(modulators=[])
      ESQ1::Modulator.build_missing(total: 2, modulators: modulators)
    end

  end

end
