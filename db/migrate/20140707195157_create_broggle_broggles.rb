class CreateBroggleBroggles < ActiveRecord::Migration
  def change
    create_table :broggle_broggles do |t|
      t.string :git_path
      t.timestamps
    end
  end
end
