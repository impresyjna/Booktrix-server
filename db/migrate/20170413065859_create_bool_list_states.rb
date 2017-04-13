class CreateBoolListStates < ActiveRecord::Migration[5.0]
  def change
    create_table :bool_list_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
