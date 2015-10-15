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

  end

end
