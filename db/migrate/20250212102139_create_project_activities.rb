class CreateProjectActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :project_activities do |t|
      t.string :activity_type
      t.text :comment
      t.string :old_status
      t.string :new_status
      t.references :project, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
