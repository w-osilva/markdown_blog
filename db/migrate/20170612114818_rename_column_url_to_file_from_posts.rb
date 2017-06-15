class RenameColumnUrlToFileFromPosts < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :url, :file
  end
end
