class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.column :screen_name, :string
      t.column :email, :string
      t.column :password, :string
      t.timestamps
    end
  end
end
