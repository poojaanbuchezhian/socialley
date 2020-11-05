class CreateGeoData < ActiveRecord::Migration[6.0]
  def change
    create_table :geo_data do |t|
      t.column :zip_code, :string
      t.column :latitude, :float
      t.column :longitude, :float
      t.column :city, :string
      t.column :state, :string
      t.column :country, :string
    end
    add_index "geo_data", ["zip_code"], :name => "zip_code_optimization"
    csv_file = "#{Rails.root}/db/migrate/geo_data.csv"
    fields = '(zip_code, latitude, longitude, city, state, country)'
    execute "LOAD DATA LOCAL INFILE '#{csv_file}' INTO TABLE geo_data FIELDS " +
    "TERMINATED BY ',' OPTIONALLY ENCLOSED BY \"\"\"\" " +
    "LINES TERMINATED BY '\n' " + fields
  end
end
