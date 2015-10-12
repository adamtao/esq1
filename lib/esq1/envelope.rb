module ESQ1

  class Envelope
    attr_accessor :number,
      :time1,
      :time2,
      :time3,
      :time4,
      :level1,
      :level2,
      :level3,
      :velocity_level,
      :velocity_attack,
      :keyboard_scaling

    def initialize(number, opts={})
      @number = number
      @time1 = opts[:time1] || 0
      @time2 = opts[:time2] || 0
      @time3 = opts[:time3] || 0
      @time4 = opts[:time4] || 0
      @level1 = opts[:level1] || 63
      @level2 = opts[:level2] || 63
      @level3 = opts[:level3] || 63
      @velocity_level = opts[:velocity_level] || 0
      @velocity_attack = opts[:velocity_attack] || 0
      @keyboard_scaling = opts[:keyboard_scaling] || 0
    end

  end

end
