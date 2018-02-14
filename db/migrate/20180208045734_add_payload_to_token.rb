class AddPayloadToToken < ActiveRecord::Migration[5.1]
  def change
    add_column :tokens, :payload, :binary, limit: 10.megabytes
  end
end
