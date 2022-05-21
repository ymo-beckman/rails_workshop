class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :source_user_id
      t.integer :target_user_id
      t.string :message_content

      t.timestamps
    end
  end
end
