class AddCounterToStory < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :clap, :integer, default: 0 
    # 在stroreis這個表格加clap這個欄位，然後型態是整數
    
  end
end
