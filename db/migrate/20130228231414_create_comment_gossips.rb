class CreateCommentGossips < ActiveRecord::Migration
  def change
    create_table :comment_gossips do |t|
      t.integer :user_id
      t.text :content
      t.integer :gossip_id
      t.integer :score_id

      t.timestamps
    end
  end
end