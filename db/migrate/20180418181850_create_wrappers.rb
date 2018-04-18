class CreateWrappers < ActiveRecord::Migration[5.1]
  def change
    create_table :wrappers do |t|
      t.string :url
      t.json 'tags'
    end
  end
end
