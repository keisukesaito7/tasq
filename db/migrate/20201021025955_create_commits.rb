class CreateCommits < ActiveRecord::Migration[6.0]
  def change
    create_table :commits do |t|
      t.text :content, null: false
      t.references :user, null: false
      t.references :task, null: false
      t.timestamps
    end
  end
end
