# This migration comes from pushable (originally 20150302191320)
class CreatePushableDevices < ActiveRecord::Migration
  def change
    create_table :pushable_devices do |t|
      t.string :token
      t.string :platform
      t.references :pushable, polymorphic: true, index: true
      t.datetime :token_expires_at

      t.timestamps null: false
    end
  end
end
