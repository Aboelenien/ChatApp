class AddMessageCountsToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :messages_count, :bigint
  end
end
