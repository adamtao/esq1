require "esq1/patch"

module ESQ1

  class Sysex
    attr_accessor :patches

    def initialize(sysex_data)
      @sysex_data = sysex_data
      @patches = parse_sysex
    end

    def parse_sysex
      patches = []
      sysex = @sysex_data.each_byte
      #        start sysex:              Ensoniq:                 ESQ-1
      if sysex.next == 0xF0 && sysex.next == 0x0F && sysex.next == 0x02
        @midi_channel = sysex.next # which we don't care about right now
        @message_type = sysex.next
        @bytes = unpacker(sysex)

        if @message_type == 0x01 # single program dump
          patches << extract_patch
        end
      end
      patches
    end

    private

    def extract_patch
      patch = ESQ1::Patch.new

      # Take the next 6 bytes for the patch name
      patch.name = Array.new(6) { |i| [@bytes.next.to_s(16)].pack('H*') }.join

      # Next 4 groups of 10 bytes are the 4 Envelopes
      patch.envelopes.each do |envelope|
        parse_envelope(envelope)
      end

      # Next 3 groups of 4 bytes are the LFOs
      patch.lfos.each do |lfo|
        parse_lfo(lfo)
      end

      # Next 3 groups of 10 bytes are the 3 Oscillators and their DCAs
      patch.oscillators.each do |osc|
        parse_oscillator(osc)
      end

      # Next byte is AM and DCA4 mod depth
      data = @bytes.next
      patch.mode.amplitude_modulation = !!(( (data & 0x80) >> 7  ) == 1)
      patch.dca4.modulators.first.amount = (data & 0x7F) >> 1

      # Next byte is OSC sync and Filter cutoff
      data = @bytes.next
      patch.mode.oscillator_sync = bit_true?(data)
      patch.filter.cutoff = data & 0x7F

      # Next byte is Filter resonance
      patch.filter.resonance = @bytes.next

      # Next byte is Filter mod source 1 and 2
      data = @bytes.next
      patch.filter.modulators.last.source = (data & 0xF0) >> 4
      patch.filter.modulators.first.source = data & 0x0F

      # Next byte is Voice restart and Filter mod (1) depth
      data = @bytes.next
      patch.mode.voice_restart = bit_true?(data)
      patch.filter.modulators.first.amount = format_number( data & 0x7F )

      # Next byte is Mono mode and Filter mod (2) depth
      data = @bytes.next
      patch.mode.mono = bit_true?(data)
      patch.filter.modulators.last.amount = format_number( data & 0x7F )

      # Next byte is Env restart and Filter keyboard tracking
      data = @bytes.next
      patch.mode.envelope_restart = bit_true?(data)
      patch.filter.keyboard_tracking = (data & 0x7F) >> 1

      # Next byte is OSC restart and Glide amount
      data = @bytes.next
      patch.mode.oscillator_restart = bit_true?(data)
      patch.mode.glide = data & 0x7F

      # Next 4 bytes have to do with split/layer
      4.times { @bytes.next }

      # Next byte is Pan and pan mod source
      data = @bytes.next
      patch.dca4.pan = (data & 0xF0) >> 4
      patch.dca4.modulators.last.source = data & 0x0F

      # Next byte is CYCle and Pan mod amount
      data = @bytes.next
      patch.mode.envelope_full_cycle = bit_true?(data)
      patch.dca4.modulators.last.amount = format_number( data & 0x3F )

      # Next should be F7 (end sysex)
      #unless @bytes.next == 0xF7
      #  raise "Unexpected byte at end of sysex data"
      #end
      patch
    end

    def parse_envelope(envelope)
      envelope.levels = Array.new(3) { |i| format_number(@bytes.next) }
      envelope.times  = Array.new(4) { |i| get_envelope_time(@bytes.next) }
      envelope.velocity_level = @bytes.next >> 2
      envelope.velocity_attack = @bytes.next
      envelope.keyboard_scaling = @bytes.next
    end

    # Might need to do some trickery here for bad patches
    def get_envelope_time(byte)
      byte
    end

    # Notes to self:
    # 0b11000000 = 0xC0
    # 0b00111111 = 0x3F
    # 0b10000000 = 0x80
    # 0b01000000 = 0x40
    def parse_lfo(lfo)
      data = @bytes.next
      lfo.wave = (data & 0xC0) >> 6
      lfo.frequency = data & 0x3F

      data = @bytes.next
      mod_part_one = (data & 0xC0) >> 6
      lfo.level1 = data & 0x3F

      data = @bytes.next
      mod_part_two = (data & 0xC0) >> 6
      lfo.level2 = data & 0x3F

      lfo.modulator.source = (mod_part_one << 2) + mod_part_two

      data = @bytes.next
      lfo.reset = bit_true?(data)
      lfo.humanize = bit_true?(data, 2)
      lfo.delay = data & 0x3F
    end

    # Notes to self:
    # 0b11110000 = 0xF0
    # 0b00001111 = 0x0F
    def parse_oscillator(oscillator)
      data = @bytes.next
      oscillator.octave = (data / 12).to_i - 3
      oscillator.semitone = (data % 12).to_i

      oscillator.fine = @bytes.next >> 3

      data = @bytes.next
      oscillator.modulators.last.source = (data & 0xF0) >> 4
      oscillator.modulators.first.source = data & 0x0F

      oscillator.modulators.first.amount = format_number(@bytes.next)
      oscillator.modulators.last.amount = format_number(@bytes.next)
      oscillator.wave = @bytes.next

      # DCA params
      dca = oscillator.dca
      data = @bytes.next
      dca.on = bit_true?(data)
      dca.level = (data & 0x7F) >> 1

      data = @bytes.next
      dca.modulators.last.source = (data & 0xF0) >> 4
      dca.modulators.first.source = data & 0x0F

      dca.modulators.first.amount = format_number(@bytes.next)
      dca.modulators.last.amount = format_number(@bytes.next)
    end

    def format_number(byte)
      num = byte >> 1
      case
        when num < 0
          raise "Number can't be negative"
        when num < 64
          num
        when num == 64
          raise "Number can't be 64"
        when num <= 127
          num - 128
      else
        raise "Number can't be translated"
      end
    end

    def bit_true?(byte, position=1)
      if position == 2
        !!(( (byte & 0x40) >> 6 ) == 1 )
      elsif position == 1
        !!(( (byte & 0x80) >> 7 ) == 1 )
      end
    end

    def unpacker(sysex)
      Enumerator.new do |e|
        sysex.each_slice(2) do |slice|
          low, high = sysex.next, sysex.next
          e << low + (high << 4)
        end
      end
    end

  end

end
