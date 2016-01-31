namespace :monitor do
  task eeg: :environment do
    MindWaveMonitor.new.perform_now
  end

  task network: :environment do
    NetworkMonitor.new.perform_now
  end
end