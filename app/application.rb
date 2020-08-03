class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    # else
    #   resp.write "Path Not Found"
    # end

    elsif req.path.match(/cart/)
    if @@cart.length == 0
      resp.write "Your cart is empty"
    else 
      @@cart.each do |cart|
        resp.write "#{cart}\n"
      end
    end

    elsif req.path.match(/add/)
      add_items = req.params["item"]
      if @@items.include? add_items
          @@cart << add_items
          resp.write "added #{add_items}"
      else
        resp.write "We don't have that item"
      end

    # if @@cart.length == 0
    #   resp.write "Your cart is empty"
    # else req.path.match(/cart/)
    #   @@cart.each do |cart|
    #     resp.write "#{cart}\n"
    #   end
    # end
    # if req.path.match(/add/)
    #   add_items = req.params["item"]
    #  @@items.include? add_items
    #   @@cart << add_items
    #   resp.write "added #{add_items}"
    # elsif
    #   resp.write "We don't have that item"
    # end




      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
