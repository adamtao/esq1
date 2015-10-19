module ESQ1

  class Mode
    attr_accessor :oscillator_sync,
      :amplitude_modulation,
      :mono,
      :glide,
      :voice_restart,
      :oscillator_restart,
      :envelope_restart,
      :envelope_full_cycle

    def initialize(opts={})
      @oscillator_sync = opts.fetch :oscillator_sync, false
      @amplitude_modulation = opts.fetch :amplitude_modulation, false
      @mono = opts.fetch :mono, false
      @glide = opts.fetch :glide, 0
      @voice_restart = opts.fetch :voice_restart, false
      @oscillator_restart = opts.fetch :oscillator_restart, false
      @envelope_restart = opts.fetch :envelope_restart, false
      @envelope_full_cycle = opts.fetch :envelope_full_cycle, false
    end

    def to_s
      parts = []
      parts << "Osc. Sync: #{ oscillator_sync }"
      parts << "AM: #{ amplitude_modulation }"
      parts << "Mono: #{ mono }"
      parts << "Glide: #{ glide }"
      parts << "Voice Restart: #{ voice_restart }"
      parts << "Osc. Restart: #{ oscillator_restart }"
      parts << "Env. Restart: #{ envelope_restart }"
      parts << "Env. Cycle: #{ envelope_full_cycle }"
      parts.join(', ')
    end

  end

end
