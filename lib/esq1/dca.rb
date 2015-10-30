require "esq1/modulator"

module ESQ1

  class DCA
    attr_accessor :number, :on, :level, :pan, :modulators
    attr_accessor :patch, :oscillator

    def initialize(number, opts={})
      @number = number
      if @number == 4
        @pan = opts.fetch :pan, 8
        @patch = opts[:patch]
      else
        @on = opts.fetch :on, true
        @level = opts.fetch :level, 63
        @oscillator = opts[:oscillator]
      end
      @modulators = initialize_modulators(opts[:modulators])
    end

    def initialize_modulators(modulators)
      modulators ||= []
      m = ESQ1::Modulator.build_missing(total: 2, modulators: modulators)
      if number == 4
        m.first.source = 6 # ENV4
        m.first.amount = 63
      end
      m
    end

    def to_s
      parts = []
      if number == 4
        parts << "Pan: #{ pan }"
      else
        parts << "Enabled: #{ on? }"
        parts << "Level: #{ level }"
      end
      parts << "Modulators: #{ modulators.map{|m| m.to_s}.join(', ')}"
      parts.join(", ")
    end

    def to_h
      if number == 4
        h = {
          'pan' => pan
        }
      else
        h = {
          'on' => on,
          'level' => level
        }
      end
      modulators.each_with_index do |m,i|
        m.to_h.each do |k,v|
          h["modulation_#{ k }_#{ i + 1 }"] = v
        end
      end
      h
    end

    def on?
      on
    end

  end

end
