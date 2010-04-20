class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|

      t.string    :login, :null => true, :limit => 80, :default => nil  # optional, you can use email instead, or both
      #t.string    :email, :null => true, :default => nil  # optional, you can use login instead, or both

      #t.string    :crypted_password,    :null => true
      #t.string    :password_salt,       :null => true

      t.string    :persistence_token,   :null => false                # required


      t.string    :oauth_token, :limit => 128
      t.string    :oauth_secret, :limit => 128

      t.string    :twitter_uid, :limit => 80
      t.string    :avatar_url
      t.string    :name, :limit => 80

    # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns

      t.timestamps
    end

  end

  def self.down
    drop_table :users
  end
end
