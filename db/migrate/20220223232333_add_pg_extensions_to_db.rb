class AddPgExtensionsToDb < ActiveRecord::Migration[7.0]
  def change
    execute "create extension unaccent"
    execute "create extension pg_trgm;"
    execute "create extension fuzzystrmatch;"
  end
end
