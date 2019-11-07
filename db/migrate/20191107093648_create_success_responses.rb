class CreateSuccessResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :success_responses do |t|
      t.string :row_number
      t.string :message
      t.timestamps
    end
    add_reference :success_responses, :identifier, index: true
  end
end
