class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    # 在username這個欄位加上index，確保不重複
    add_column :users, :intro, :text
  end
end
