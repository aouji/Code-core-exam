class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :body
      t.boolean :resolved, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
