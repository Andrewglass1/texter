class CreateIncomingTexts < ActiveRecord::Migration
  def change
    create_table :incoming_texts do |t|
      t.string :from
      t.string :body
      t.timestamps
    end
  end
end
