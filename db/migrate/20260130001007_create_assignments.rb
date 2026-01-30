class CreateAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
