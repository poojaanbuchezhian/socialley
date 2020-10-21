class AddAuthorizationToken < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authorization_token, :string
  end
end
