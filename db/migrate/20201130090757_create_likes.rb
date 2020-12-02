class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.references :commit, foreign_key: true
      t.timestamps
    end
  end
end
