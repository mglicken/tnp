class AddSequenceToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :sequence, :integer
  end
end
