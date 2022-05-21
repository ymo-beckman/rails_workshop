class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :avatar_url

      t.timestamps
    end
  end
end
