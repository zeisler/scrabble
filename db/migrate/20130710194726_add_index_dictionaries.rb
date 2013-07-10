class AddIndexDictionaries < ActiveRecord::Migration
  def change
    add_index :dictionaries, :word
  end
end
