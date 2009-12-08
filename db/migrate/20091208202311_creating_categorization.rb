class CreatingCategorization < ActiveRecord::Migration
  def self.up
    create_table :categorizations, :force => true do |t|
      t.references :article, :category
      t.timestamps
    end
  end

  def self.down
    drop_table :categorization
  end
end
