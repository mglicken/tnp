class AddActiveToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :active, :boolean
  end
end
