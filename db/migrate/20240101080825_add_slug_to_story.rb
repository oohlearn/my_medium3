class AddSlugToStory < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :slug, :string
    add_index :stories, :slug, unique: true
    # 用friendly_id 在story這個表格製造一個叫做slug的欄位，型別是字串，然後會給他一個獨有的index
  end
end
