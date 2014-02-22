class CreateMeters < ActiveRecord::Migration
  def change
    create_table :meters do |t|
      t.float :a_on, :null => false
      t.float :heat_ac, :null => false
      t.float :refrig, :null => false
      t.float :dryer, :null => false
      t.float :cooking, :null => false
      t.float :other, :null => false
      t.datetime :time, :null => false

      t.timestamps
    end
  end
end
