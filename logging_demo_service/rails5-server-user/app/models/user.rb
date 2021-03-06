=begin
User API

Move your app forward with the User API

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git

=end


class User < ApplicationRecord
include DataMapper::Resource
  property :id,  Serial
  property :name,   String
  property :user_id, String
  property :email,   String
  property :sex, Integer
  property :rate, Integer
end

DataMapper.auto_migrate!