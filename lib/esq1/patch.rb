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

    def to_s
      "#{@name}:" +
        "\n  Oscillators:\n\t#{ oscillators.map{|o| o.to_s}.join("\n\t")}" +
        "\n  DCAs:\n\t#{ oscillators.map{|o| o.dca.to_s }.join("\n\t")}" +
        "\n  Filter:\n\t#{ filter.to_s }" +
        "\n  DCA4:\n\t#{ dca4.to_s }" +
        "\n  LFOs:\n\t#{ lfos.map{|l| l.to_s}.join("\n\t")}" +
        "\n  Envelopes:\n\t#{ envelopes.map{|e| e.to_s}.join("\n\t")}" +
        "\n  Mode:\n\t#{ mode.to_s }"
    end

    def to_h
      h = {'name' => name}
      oscillators.each do |osc|
        osc.to_h.each do |k,v|
          h["oscillator_#{ osc.number }_#{ k }"] = v
        end
        osc.dca.to_h.each do |k,v|
          h["dca_#{ osc.dca.number }_#{ k }"] = v
        end
      end
      dca4.to_h.each do |k,v|
        h["dca_#{ dca4.number }_#{ k }"] = v
      end
      filter.to_h.each do |k,v|
        h["filter_#{ k }"] = v
      end
      lfos.each do |lfo|
        lfo.to_h.each do |k,v|
          h["lfo_#{ lfo.number }_#{ k }"] = v
        end
      end
      envelopes.each do |env|
        env.to_h.each do |k,v|
          h["envelope_#{ env.number }_#{ k }"] = v
        end
      end
      h.merge mode.to_h
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
