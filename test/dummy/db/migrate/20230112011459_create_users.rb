class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.datetime :confirmed_at
      t.string :unconfirmed_email
      t.string :first_name
      t.string :last_name
      t.boolean :admin

      t.timestamps
    end
  end
end
