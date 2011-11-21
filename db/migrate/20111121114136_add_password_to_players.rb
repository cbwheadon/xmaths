class AddPasswordToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :password, :text
    Player.all.each { |f| f.update_attributes!(:password => 'password') }
  end
end
