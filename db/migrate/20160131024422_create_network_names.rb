class CreateNetworkNames < ActiveRecord::Migration[5.0]
  def change
    create_table :network_names do |t|
      t.string :name
      t.timestamps
    end
    add_index :network_names, [:name]
  end
end
