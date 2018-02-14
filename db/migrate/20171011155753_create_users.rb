class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.timestamps
      t.column :email,           :string, null: false
      t.column :username,        :string, null: false
      t.column :password_digest, :string, null: false
      t.column :info_about,      :string, null: false, default: ''
      t.column :permissions,     :string, null: false, default: [], array: true

      t.index :email, unique: true
    end
  end
end
