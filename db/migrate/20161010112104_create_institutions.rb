class CreateInstitutions < ActiveRecord::Migration[5.0]
  def change
    create_table :institutions, id: false do |t|
      t.string :ins_id, null: false
      t.string :name, null: false
      t.string :country
      t.string :state
      t.string :city
      t.timestamps
    end
    execute %Q{ ALTER TABLE "institutions" ADD PRIMARY KEY("ins_id");}
  end
end
