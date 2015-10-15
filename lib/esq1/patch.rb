require "esq1/oscillator"
require "esq1/modulator"
require "esq1/filter"
require "esq1/lfo"
require "esq1/envelope"
require "esq1/mode"
require "esq1/sysex"

module ESQ1

  class Patch
    attr_accessor :name, :oscillators, :filter, :dca4, :lfos, :envelopes, :mode

    def initialize(opts={})
      @name = opts.fetch :name, "NAME"
      @filter = opts.fetch :filter, ESQ1::Filter.new
      @dca4 = opts.fetch :dca4, ESQ1::DCA.new(4, patch: self)
      @mode = opts.fetch :mode, ESQ1::Mode.new

      @oscillators = initialize_oscillators(opts[:oscillators])
      @envelopes = initialize_envelopes(opts[:envelopes])
      @lfos = initialize_lfos(opts[:lfos])
    end

    def initialize_oscillators(oscillators)
      oscillators ||= []
      o = Array.new(3) # Patches have 3 Oscillators
      o.each_with_index do |z,i|
        if oscillators[i].is_a?(ESQ1::Oscillator)
          o[i] = oscillators[i]
        else
          o[i] = ESQ1::Oscillator.new(i + 1)
        end
        o[i].patch ||= self
      end
      o
    end

    def initialize_lfos(lfos)
      lfos ||= []
      l = Array.new(3) # Patches have 3 LFOs
      l.each_with_index do |z,i|
        if lfos[i].is_a?(ESQ1::LFO)
          l[i] = lfos[i]
        else
          l[i] = ESQ1::LFO.new(i + 1)
        end
        l[i].patch ||= self
      end
      l
    end

    def initialize_envelopes(envelopes)
      envelopes ||= []
      e = Array.new(4) # Paches have 4 Envelopes
      e.each_with_index do |z,i|
        if envelopes[i].is_a?(ESQ1::Envelope)
          e[i] = envelopes[i]
        else
          e[i] = ESQ1::Envelope.new(i + 1)
        end
        e[i].patch ||= self
      end
      e
    end

  end

end
