class AddIndexToMessages < ActiveRecord::Migration[5.2]
  def change
      add_index :messages, [:number, :chat_id], unique: true
  end
end
