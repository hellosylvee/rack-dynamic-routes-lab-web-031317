require 'pry'
class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env) #sent from the client(browser), response is dependent on the request

    if req.path.match(/items/)
      # binding.pry
      item_name = req.path.split("/items/").last #item name as a string,
      item = @@items.find {|i| i.name == item_name} #item object
      if !!item #true
        resp.write "#{item.price}" #line 11, calling on the item variable
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
