class AddPgExtensionsToDb < ActiveRecord::Migration[7.0]
  def up
    execute "create extension unaccent"
    execute "create extension pg_trgm;"
    execute "create extension fuzzystrmatch;"
  end

  def down
    execute "drop extension unaccent"
    execute "drop extension pg_trgm;"
    execute "drop extension fuzzystrmatch;"
  end
end
