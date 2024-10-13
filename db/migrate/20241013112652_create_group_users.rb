class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
      t.boolean :is_admin, default: false

      t.timestamps
    end
  end
end
