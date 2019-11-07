class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :message
      t.bigint :number
      t.bigint :messages_count
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end
