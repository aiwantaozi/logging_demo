=begin
Uber API

Move your app forward with the Uber API

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git

=end

class InitTables < ActiveRecord::Migration
  def change
    create_table "bill".pluralize.to_sym, id: false do |t|
      t.float :cost

      t.timestamps
    end

    create_table "error".pluralize.to_sym, id: false do |t|
      t.integer :code
      t.string :message
      t.string :fields

      t.timestamps
    end

    create_table "transaction".pluralize.to_sym, id: false do |t|
      t.string :uuid
      t.string :start_source
      t.string :end_destination
      t.string :start_time
      t.float :duration
      t.string :user_id
      t.string :driver_id
      t.float :rate
      t.string :product_id

      t.timestamps
    end

    create_table "transactions".pluralize.to_sym, id: false do |t|
      t.integer :offset
      t.integer :limit
      t.integer :count
      t.string :history

      t.timestamps
    end

  end
end
