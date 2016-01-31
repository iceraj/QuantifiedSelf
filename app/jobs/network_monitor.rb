class NetworkMonitor < ApplicationJob
  def perform
    @network_name = nil
    @network_host = nil
    @network_record = nil
    process
  end

  def process
    while true
      name = my_network_name
      hostname = my_host_name
      if @network_name.nil? || @network_name.name != name
        @network_name = NetworkName.where(name: name).first_or_create!
      end
      if @network_host.nil? || @network_host.name != hostname
        @network_host = NetworkHost.where(name: hostname).first_or_create!
      end
      if @network_record.nil? ||
          @network_record.network_host != @network_host ||
          @network_record.network_name != @network_name
        @network_record.save! unless @network_record.nil?
        @network_record= NetworkRecord.new
        @network_record.start_time= Time.now
        @network_record.end_time= Time.now
        @network_record.network_host= @network_host
        @network_record.network_name= @network_name
      end
      @network_record.end_time= Time.now
      @network_record.save!
      Rails.logger&.debug @network_record&.attributes
      sleep 1
    end
  end

  def my_network_name
    name = `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep SSID | grep -v BSSID | sed 's/.*SSID: //g'`
    name.scrub.strip
  end

  def my_host_name
    hostname = `hostname`
    hostname.scrub.strip
  end

end