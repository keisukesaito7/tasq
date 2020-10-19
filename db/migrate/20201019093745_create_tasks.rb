class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.text :title,      null: false
      t.text :purpose,    null: false
      t.text :goal,       null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
