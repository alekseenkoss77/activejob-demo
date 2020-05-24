class CreateVisitorStatsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :visitor_stats do |t|
      t.string :ip_address
      t.string :city
      t.string :country
      t.string :user_agent
      t.integer :visits
      t.integer :time_spent
      t.timestamps
    end

    add_index :visitor_stats, :ip_address
    add_index :visitor_stats, [:country, :city, :user_agent]
  end
end
