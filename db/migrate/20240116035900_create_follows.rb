class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :following_id

      t.timestamps
    end
    add_index :follows, :following_id
  end
end
