class CreateEegRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :eeg_records do |t|
      t.datetime :timestamp
      t.integer :attention
      t.integer :meditation
      t.float :delta
      t.float :theta
      t.float :low_alpha
      t.float :high_alpha
      t.float :low_beta
      t.float :high_beta
      t.float :low_gamma
      t.float :high_gamma
      t.integer :poor_signal
      t.integer :blinks
      t.float :max_blink

      t.timestamps
    end
    add_index :eeg_records, [:timestamp, :attention, :meditation]
  end
end
