class CreateApiV1Memories < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_memories, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :prompt
      t.text :story
      t.string :title
      t.boolean :public
      t.boolean :favorite
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
