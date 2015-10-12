require "esq1/modulator"

module ESQ1

  class DCA
    attr_accessor :number, :on, :level, :pan, :modulators

    def initialize(number, opts={})
      @number = number
      if @number == 4
        @pan = opts[:pan] || 8
      else
        @on = opts[:on] || true
        @level = opts[:level] || 63
      end
      @modulators = initialize_modulators(opts[:modulators] || [])
    end

    def initialize_modulators(modulators=[])
      m = ESQ1::Modulator.build_missing(total: 2, modulators: modulators)
      if @number == 4
        m.first.source = 6
        m.first.amount = 64
      end
      m
    end

  end

end
