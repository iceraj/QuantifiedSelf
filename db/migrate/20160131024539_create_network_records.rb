class CreateNetworkRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :network_records do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :network_name_id
      t.integer :network_host_id

      t.timestamps
    end
    add_index :network_records, :start_time
    add_index :network_records, :end_time
  end
end
