class CreateNetworkHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :network_hosts do |t|
      t.string :name

      t.timestamps
    end
    add_index :network_hosts, [:name]
  end
end
