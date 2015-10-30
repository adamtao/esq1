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
    attr_accessor :patch

    def initialize(number, opts={})
      @number = number
      @time1 = opts.fetch :time1, 0
      @time2 = opts.fetch :time2, 0
      @time3 = opts.fetch :time3, 0
      @time4 = opts.fetch :time4, 0
      @level1 = opts.fetch :level1, 63
      @level2 = opts.fetch :level2, 63
      @level3 = opts.fetch :level3, 63
      @velocity_level = opts.fetch :velocity_level, 0
      @velocity_attack = opts.fetch :velocity_attack, 0
      @keyboard_scaling = opts.fetch :keyboard_scaling, 0
      @patch = opts[:patch]
    end

    def levels
      [@level1, @level2, @level3]
    end

    def levels=(data=[])
      @level1, @level2, @level3 = data
    end

    def times
      [@time1, @time2, @time3, @time4]
    end

    def times=(data=[])
      @time1, @time2, @time3, @time4 = data
    end

    def to_s
      parts = []
      parts << "Times: #{ times.join(', ') }"
      parts << "Levels: #{ levels.join(', ') }"
      parts << "Velocity Level: #{ velocity_level }"
      parts << "Velocity Attack: #{ velocity_attack }"
      parts << "Key Scaling: #{ keyboard_scaling }"
      parts.join(', ')
    end

    def to_h
      {
        'time1' => time1,
        'time2' => time2,
        'time3' => time3,
        'time4' => time4,
        'level1' => level1,
        'level2' => level2,
        'level3' => level3,
        'velocity_level' => velocity_level,
        'velocity_attack' => velocity_attack,
        'keyboard_scaling' => keyboard_scaling
      }
    end

  end

end
