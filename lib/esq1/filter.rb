require "esq1/modulator"

module ESQ1

  class Filter
    attr_accessor :cutoff, :resonance, :keyboard_tracking, :modulators

    def initialize(opts={})
      @cutoff = opts.fetch :cutoff, 127
      @resonance = opts.fetch :resonance, 0
      @keyboard_tracking = opts.fetch :keyboard_tracking, 15
      @modulators = initialize_modulators(opts[:modulators])
    end

    def initialize_modulators(modulators)
      modulators ||= []
      ESQ1::Modulator.build_missing(total: 2, modulators: modulators)
    end

    def to_s
      parts = []
      parts << "Cutoff: #{ cutoff }"
      parts << "Resonance: #{ resonance }"
      parts << "Key Track: #{ keyboard_tracking }"
      parts << "Modulators: #{ modulators.map{|m| m.to_s}.join(', ')}"
      parts.join(', ')
    end

  end

end
