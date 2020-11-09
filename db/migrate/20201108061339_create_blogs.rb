class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.column :user_id, :integer
      t.timestamps
    end
  end
end
