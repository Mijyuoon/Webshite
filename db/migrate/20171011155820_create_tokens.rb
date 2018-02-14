class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.timestamps
      t.column :value, :string, null: false
      t.column :kind, :string, null: false
      t.column :expires_at, :datetime

      t.index :value, unique: true
      t.references :tokenable, polymorphic: true, index: true
    end
  end
end
