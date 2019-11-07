class CreateErrorResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :error_responses do |t|
      t.string :row_number
      t.string :message
      t.timestamps
    end
    add_reference :error_responses, :identifier, index: true
  end
end
