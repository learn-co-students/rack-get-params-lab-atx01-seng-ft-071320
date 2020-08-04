class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      @@cart.each do |cart|
        resp.write "#{cart}\n"
      end
    end
    if req.path.match(/items/)  #if request path match /items
      @@items.each do |item|  
        resp.write "#{item}\n"    #returns @@items
      end
    elsif req.path.match(/add/)
      item = req.params["item"]
      resp.write add_item(item)
    elsif req.path.match(/search/)  #if request path match /search
      search_term = req.params["q"]   
      resp.write handle_search(search_term) #/search?q=one of the @@items
    else resp.write "Your cart is empty"
    end
    resp.finish
  end
  
  def add_item(item)
    if @@items.include?(item)
      @@cart << item
      return "added #{item}"
    else
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
