# Ensoniq ESQ-1

This gem aims to help with interacting with the Ensoniq ESQ-1
synthesizer from ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'esq1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install esq1

## Usage

Initialize a patch (sound preset) like so:

```ruby
patch = ESQ1::Patch.new
```

Inspect the object to see how the attributes are organized. (More
documentation needed here.)

Patches can also be read from a MIDI system exclusive file dumped from
an actual ESQ-1. Currently, only single patch sysex files are supported.

```ruby
sysex_data = File.open("patch_file.syx", 'rb').read

sysex = ESQ1::Sysex.new( sysex_data )

patch = sysex.patches.first
```

The patch can then be displayed as text or a flat hash.

```ruby
patch.to_s

# Yields something like this:
BASIC :
  Oscillators:
        Wave: SAW, Octave: 0, Semitone: 0, Fine: 0, Modulators: LFO1: 5, *OFF*: 0
        Wave: NOISE_2, Octave: -3, Semitone: 0, Fine: 0, Modulators: LFO1: 5, *OFF*: 0
        Wave: SINE, Octave: 1, Semitone: 0, Fine: 0, Modulators: LFO1: 5, *OFF*: 0
  DCAs:
        Enabled: true, Level: 63, Modulators: *OFF*: 0, LFO1: 0
        Enabled: false, Level: 0, Modulators: *OFF*: 0, LFO1: 0
        Enabled: false, Level: 0, Modulators: *OFF*: 0, *OFF*: 0
  Filter:
        Cutoff: 100, Resonance: 0, Key Track: 0, Modulators: ENV3: 0, LFO1: 0
  DCA4:
        Pan: 8, Modulators: ENV4: 63, *OFF*: 0
  LFOs:
        Wave: TRI, Frequency: 21, Levels: 0, 21, Delay: 0, Reset: false, Humanize: true, Modulator: WHEEL
        Wave: NOI, Frequency: 63, Levels: 63, 63, Delay: 63, Reset: false, Humanize: true, Modulator: WHEEL
        Wave: NOI, Frequency: 16, Levels: 0, 20, Delay: 1, Reset: false, Humanize: false, Modulator: WHEEL
  Envelopes:
        Times: 0, 6, 63, 20, Levels: -6, 0, 0, Velocity Level: 63, Velocity Attack: 0, Key Scaling: 9
        Times: 0, 50, 63, 20, Levels: 63, 50, 45, Velocity Level: 0, Velocity Attack: 0, Key Scaling: 9
        Times: 0, 18, 0, 20, Levels: 63, 0, 0, Velocity Level: 26, Velocity Attack: 0, Key Scaling: 0
        Times: 0, 32, 32, 20, Levels: 63, 63, 63, Velocity Level: 20, Velocity Attack: 0, Key Scaling: 0
  Mode:
        Osc. Sync: false, AM: false, Mono: false, Glide: 0, Voice Restart: true, Osc. Restart: false, Env. Restart: false, Env. Cycle: false

```

```ruby
patch.to_h

# Yields a hash with these keys:
{
  "name"=>"BASIC ",
  "oscillator_1_wave"=>0,
  "oscillator_1_wave_name"=>"SAW",
  "oscillator_1_octave"=>0,
  "oscillator_1_semitone"=>0,
  "oscillator_1_fine"=>0,
  "oscillator_1_modulation_source_1"=>0,
  "oscillator_1_modulation_source_name_1"=>"LFO1",
  "oscillator_1_modulation_amount_1"=>5,
  "oscillator_1_modulation_source_2"=>15,
  "oscillator_1_modulation_source_name_2"=>"*OFF*",
  "oscillator_1_modulation_amount_2"=>0,
  "dca_1_on"=>true,
  "dca_1_level"=>63,
  "dca_1_modulation_source_1"=>15,
  "dca_1_modulation_source_name_1"=>"*OFF*",
  "dca_1_modulation_amount_1"=>0,
  "dca_1_modulation_source_2"=>0,
  "dca_1_modulation_source_name_2"=>"LFO1",
  "dca_1_modulation_amount_2"=>0,
  "oscillator_2_wave"=>6,
  "oscillator_2_wave_name"=>"NOISE_2",
  "oscillator_2_octave"=>-3,
  "oscillator_2_semitone"=>0,
  "oscillator_2_fine"=>0,
  "oscillator_2_modulation_source_1"=>0,
  "oscillator_2_modulation_source_name_1"=>"LFO1",
  "oscillator_2_modulation_amount_1"=>5,
  "oscillator_2_modulation_source_2"=>15,
  "oscillator_2_modulation_source_name_2"=>"*OFF*",
  "oscillator_2_modulation_amount_2"=>0,
  "dca_2_on"=>false,
  "dca_2_level"=>0,
  "dca_2_modulation_source_1"=>15,
  "dca_2_modulation_source_name_1"=>"*OFF*",
  "dca_2_modulation_amount_1"=>0,
  "dca_2_modulation_source_2"=>0,
  "dca_2_modulation_source_name_2"=>"LFO1",
  "dca_2_modulation_amount_2"=>0,
  "oscillator_3_wave"=>2,
  "oscillator_3_wave_name"=>"SINE",
  "oscillator_3_octave"=>1,
  "oscillator_3_semitone"=>0,
  "oscillator_3_fine"=>0,
  "oscillator_3_modulation_source_1"=>0,
  "oscillator_3_modulation_source_name_1"=>"LFO1",
  "oscillator_3_modulation_amount_1"=>5,
  "oscillator_3_modulation_source_2"=>15,
  "oscillator_3_modulation_source_name_2"=>"*OFF*",
  "oscillator_3_modulation_amount_2"=>0,
  "dca_3_on"=>false,
  "dca_3_level"=>0,
  "dca_3_modulation_source_1"=>15,
  "dca_3_modulation_source_name_1"=>"*OFF*",
  "dca_3_modulation_amount_1"=>0,
  "dca_3_modulation_source_2"=>15,
  "dca_3_modulation_source_name_2"=>"*OFF*",
  "dca_3_modulation_amount_2"=>0,
  "dca_4_pan"=>8,
  "dca_4_modulation_source_1"=>6,
  "dca_4_modulation_source_name_1"=>"ENV4",
  "dca_4_modulation_amount_1"=>63,
  "dca_4_modulation_source_2"=>15,
  "dca_4_modulation_source_name_2"=>"*OFF*",
  "dca_4_modulation_amount_2"=>0,
  "filter_cutoff"=>100,
  "filter_resonance"=>0,
  "filter_keyboard_tracking"=>0,
  "filter_modulation_source_1"=>5,
  "filter_modulation_source_name_1"=>"ENV3",
  "filter_modulation_amount_1"=>0,
  "filter_modulation_source_2"=>0,
  "filter_modulation_source_name_2"=>"LFO1",
  "filter_modulation_amount_2"=>0,
  "lfo_1_frequency"=>21,
  "lfo_1_wave"=>0,
  "lfo_1_wave_name"=>"TRI",
  "lfo_1_level1"=>0,
  "lfo_1_level2"=>21,
  "lfo_1_delay"=>0,
  "lfo_1_reset"=>false,
  "lfo_1_humanize"=>true,
  "lfo_1_modulation_source_name"=>"WHEEL",
  "lfo_2_frequency"=>63,
  "lfo_2_wave"=>3,
  "lfo_2_wave_name"=>"NOI",
  "lfo_2_level1"=>63,
  "lfo_2_level2"=>63,
  "lfo_2_delay"=>63,
  "lfo_2_reset"=>false,
  "lfo_2_humanize"=>true,
  "lfo_2_modulation_source_name"=>"WHEEL",
  "lfo_3_frequency"=>16,
  "lfo_3_wave"=>3,
  "lfo_3_wave_name"=>"NOI",
  "lfo_3_level1"=>0,
  "lfo_3_level2"=>20,
  "lfo_3_delay"=>1,
  "lfo_3_reset"=>false,
  "lfo_3_humanize"=>false,
  "lfo_3_modulation_source_name"=>"WHEEL",
  "envelope_1_time1"=>0,
  "envelope_1_time2"=>6,
  "envelope_1_time3"=>63,
  "envelope_1_time4"=>20,
  "envelope_1_level1"=>-6,
  "envelope_1_level2"=>0,
  "envelope_1_level3"=>0,
  "envelope_1_velocity_level"=>63,
  "envelope_1_velocity_attack"=>0,
  "envelope_1_keyboard_scaling"=>9,
  "envelope_2_time1"=>0,
  "envelope_2_time2"=>50,
  "envelope_2_time3"=>63,
  "envelope_2_time4"=>20,
  "envelope_2_level1"=>63,
  "envelope_2_level2"=>50,
  "envelope_2_level3"=>45,
  "envelope_2_velocity_level"=>0,
  "envelope_2_velocity_attack"=>0,
  "envelope_2_keyboard_scaling"=>9,
  "envelope_3_time1"=>0,
  "envelope_3_time2"=>18,
  "envelope_3_time3"=>0,
  "envelope_3_time4"=>20,
  "envelope_3_level1"=>63,
  "envelope_3_level2"=>0,
  "envelope_3_level3"=>0,
  "envelope_3_velocity_level"=>26,
  "envelope_3_velocity_attack"=>0,
  "envelope_3_keyboard_scaling"=>0,
  "envelope_4_time1"=>0,
  "envelope_4_time2"=>32,
  "envelope_4_time3"=>32,
  "envelope_4_time4"=>20,
  "envelope_4_level1"=>63,
  "envelope_4_level2"=>63,
  "envelope_4_level3"=>63,
  "envelope_4_velocity_level"=>20,
  "envelope_4_velocity_attack"=>0,
  "envelope_4_keyboard_scaling"=>0,
  "oscillator_sync"=>false,
  "amplitude_modulation"=>false,
  "mono"=>false,
  "glide"=>0,
  "voice_restart"=>true,
  "oscillator_restart"=>false,
  "envelope_restart"=>false,
  "envelope_full_cycle"=>false
}
```
Note: Patch layering and splits are ignored as these are dependent on
other patches being saved to specific locations--which change often.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/esq1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

