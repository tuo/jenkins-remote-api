module Ci
  class ColorToStatus

    COLOR_STATUS_MAPPING = {
      /^blue$/              => 'success',
      /^red$/               => 'failure',
      /.*anime$/            => 'building',
      /^disabled$/          => 'disabled',
      /^aborted$/           => 'aborted',
      /^yellow$/            => 'unstable', #rare
      /^grey$/              => 'disabled',
    }
    
    def self.get_status_to(color)
      result_color_key = COLOR_STATUS_MAPPING.keys.find { | color_regex | color_regex.match(color)}
      raise "This color '#{color}' and its corresponding status hasn't been added to library, pls contact author." if result_color_key.nil?
      COLOR_STATUS_MAPPING[result_color_key]
    end
  end
end
