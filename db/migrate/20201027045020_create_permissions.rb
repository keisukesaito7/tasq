class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.timestamps
    end
  end
end
