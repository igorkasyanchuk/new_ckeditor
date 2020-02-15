class CreateCkEditorImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ck_editor_images do |t|
      t.string :file
      t.integer :user_id, index: true
      t.integer :parent_id
      t.string :parent_type

      t.datetime :created_at
    end
    add_index :ck_editor_images, [:parent_id, :parent_type]
  end
end
