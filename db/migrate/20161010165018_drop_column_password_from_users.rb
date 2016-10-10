class DropColumnPasswordFromUsers < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ ALTER TABLE "users" DROP "password"; }
  execute %Q{ ALTER TABLE "users" DROP "salt"; }
end
