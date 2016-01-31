class MindWaveMonitor < ApplicationJob

  def perform
    @logger = Rails.logger
    @blinks = 0
    @max_blink = 0
    establish_connection { |data| process(data) }
  end

  def establish_connection &block
    s = TCPSocket.new "localhost", 13854
    s.puts '{"enableRawOutput": false, "format": "Json"}'
    while true
      line = s.readline
      begin
        data = JSON.parse(line)
      rescue JSON::ParserError => e
        next
      end
      yield data
    end
    s.close
  end

  def process(data)
    @logger.debug data

    if data.key? "eSense"
      record = EegRecord.new
      record.timestamp = Time.now
      e_sense = data["eSense"]
      record.attention = e_sense["attention"] unless e_sense.nil?
      record.meditation = e_sense["meditation"] unless e_sense.nil?
      eeg_power = data["eegPower"]
      record.delta = eeg_power["delta"] unless eeg_power.nil?
      record.theta = eeg_power["theta"] unless eeg_power.nil?
      record.low_alpha = eeg_power["lowAlpha"] unless eeg_power.nil?
      record.high_alpha = eeg_power["highAlpha"] unless eeg_power.nil?
      record.low_beta = eeg_power["lowBeta"] unless eeg_power.nil?
      record.high_beta = eeg_power["highBeta"] unless eeg_power.nil?
      record.low_gamma = eeg_power["lowGamma"] unless eeg_power.nil?
      record.high_gamma = eeg_power["highGamma"] unless eeg_power.nil?
      record.poor_signal = data["poorSignalLevel"]
      record.blinks = @blinks
      record.max_blink = @max_blink
      @blinks = 0
      @max_blink = 0
      @logger.info record.poor_signal
      if (0..199).include? record.poor_signal
        # Valid signal!
        record.save!
      end
    end
    if data.key? "blinkStrength"
      blink_strength = data["blinkStrength"]
      @blinks += 1
      @max_blink = [@max_blink, blink_strength].max
    end
  end

end