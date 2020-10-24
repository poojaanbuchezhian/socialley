class CreateSpecs < ActiveRecord::Migration[6.0]
  def change
    create_table :specs do |t|
      t.column :user_id, :integer, :null => false
      t.column :first_name, :string, :default => ""
      t.column :last_name, :string, :default => ""
      t.column :gender, :string
      t.column :birthdate, :date
      t.column :occupation, :string, :default => ""
      t.column :city, :string, :default => ""
      t.column :state, :string, :default => ""
      t.column :zip_code, :string, :default => ""
      t.timestamps
    end
  end
end
