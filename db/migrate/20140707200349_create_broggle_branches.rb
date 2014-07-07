class CreateBroggleBranches < ActiveRecord::Migration
  def change
    create_table :broggle_branches do |t|
      t.belongs_to :broggle
      t.timestamps
    end
  end
end
