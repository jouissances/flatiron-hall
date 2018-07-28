class Projects < ActiveRecord::Migration
  def change

    create_table :projects do |t|
      t.string :title
      t.string :type
      t.string :description
      t.string :github
      t.string :external_uri
    end

  end
end
