namespace :monitor do
  task eeg: :environment do
    MindWaveMonitor.new.perform_now
  end
end