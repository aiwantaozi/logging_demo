=begin
User API

Move your app forward with the User API

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git

=end
Rails.application.routes.draw do

  def add_swagger_route http_method, path, opts = {}
    full_path = path.gsub(/{(.*?)}/, ':\1')
    match full_path, to: "#{opts.fetch(:controller_name)}##{opts[:action_name]}", via: http_method
  end

  add_swagger_route 'POST', '/v1/me', controller_name: 'defaults', action_name: 'me_post'
  add_swagger_route 'GET', '/v1/me', controller_name: 'users', action_name: 'me_get'
end