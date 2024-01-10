class AddDeletedAtToStory < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :deleted_at, :datetime
    add_index :stories, :deleted_at
  end
end


# 在stories加了個delet_at的欄位，型別是datetime，同時加上index
# rails g migration add_deleted_at_to_story delete_at:datetime:index