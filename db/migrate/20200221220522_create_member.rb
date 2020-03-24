class CreateMember < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :organization
      t.string :image
    end
  end
end
