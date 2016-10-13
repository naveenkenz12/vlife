class AddParentIdForeignKey < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ALTER TABLE "posts" ADD FOREIGN KEY("parent_id") REFERENCES "posts"("p_id"); }
end
