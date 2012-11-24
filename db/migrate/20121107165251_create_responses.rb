class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text     :body
      t.string   :to
      t.string   :status, :default => "pending"
      t.integer  :message_id

      t.timestamps
    end
  end
end
