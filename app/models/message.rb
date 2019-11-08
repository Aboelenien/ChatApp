class Message < ApplicationRecord
  belongs_to :chat,  dependent: :destroy
  before_save :force_index

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
     mappings dynamic: false do
       indexes :message, type: :text
       indexes :chat_id, type: :bigint
     end
  end

  def as_indexed_json(options={})
     self.as_json(root: false, only: [:number, :message, :chat_id])
  end

  def self.serach(query)
   __elasticsearch__.search(query)
  end

  def force_index
    __elasticsearch__.instance_variable_set(:@__changed_model_attributes, nil)
  end

end
