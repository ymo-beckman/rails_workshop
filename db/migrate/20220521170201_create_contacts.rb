class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.belongs_to :user
      t.integer :contact_id
    end
  end
end
