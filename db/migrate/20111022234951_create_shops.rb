class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name,                         null: false
      t.string :theme,                        null: false, default: 'nootstrap'
      t.string :time_zone,                    null: false, default: 'UTC'
      t.string :intercept_email,              null:false
      t.string :from_email,                   null:false
      t.string :default_creditcard_action,    null:false,  default: 'authorize'
      t.string :process_credit_card_for_real, default: false
      t.string :gateway
      t.string :phone_number
      t.string :twitter_handle
      t.string :contact_email
      t.string :facebook_url
      t.string :google_analytics_tracking_id

      t.timestamps
    end
  end
end
