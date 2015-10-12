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
      @oscillator_sync = opts[:oscillator_sync] || false
      @amplitude_modulation = opts[:amplitude_modulation] || false
      @mono = opts[:mono] || false
      @glide = opts[:glide] || 0
      @voice_restart = opts[:voice_restart] || false
      @oscillator_restart = opts[:oscillator_restart] || false
      @envelope_restart = opts[:envelope_restart] || false
      @envelope_full_cycle = opts[:envelope_full_cycle] || false
    end

  end

end
