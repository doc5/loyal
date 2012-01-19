class CreateTipScores < ActiveRecord::Migration
  def change
    create_table :tip_scores do |t|
      t.references :resource, :polymorphic => true 
      t.integer :created_by
      t.string :created_ip
      
      t.integer :context_flag
      t.integer :point
      
      t.timestamps
    end
  end
end
