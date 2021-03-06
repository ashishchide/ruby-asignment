require 'json'
require_relative 'file'

class Product
  include FileOperation

  def user_input(entity)
    puts "Enter the #{entity}"
    entity = gets.strip
  end

  def new_id
    if File.zero?("db.txt")
    product = 1
    else
    f = File.read("db.txt")
    product  = f.split("\n").last.split("|")[0].to_i
    end
  end

  def return_product
    f = File.read("db.txt")
    product  = f.split("\n")
  end

  def list_product
     puts File.read("db.txt")
  end

  def new_product
    input_arr = ["name" , "price" , "Company Name", "stock"]
    a = []
    input_arr.each do  |x|
      a << user_input(x)
      end
    id = new_id + 1
    a.unshift(id)
    product = {id: a[0],name: a[1],price: a[2],company: a[3] ,stock:a[4]}
    is_empty("db.txt" ,product)
    append(to_lineh(product), "db.txt")
    puts "The Item is successfully added"
  end

  def remove_product
    id = user_input("id").to_i
    new_data = []
    return_product.each do |x|
      product = x.split("|")
      if product[0].to_i != id
        new_data << product
      end
    end
    update_data(new_data)
   end

  def search_product
    n = user_input("Name to search")
    search = []
    return_product.each do |x|
      product = x.split("|")
      if product[1]=~ /#{n}/
        p product
      end
    end
  end

  def edit_product
    i = user_input("Product id").to_i
    update = []
    return_product.each do |x|
      product = x.split("|")
      if product[0].to_i == i
          n = user_input("new name")
          pr  = user_input("new Price")
          product[1] = n
          product[2] = pr
          update << product
       else
          update << product
       end
      end
      update_data(update)
    end

    def update_data(data)
      File.open("db.txt", "w")
      data.each do |x|
        append(to_line(x), "db.txt")
        end
    end

  def buy_product
    list_product
    i = user_input("id").to_i
    new_data = []
    return_product.each do |x|
      product = x.split("|")
      if product[0].to_i == i && product[4].to_i > 0
        place_order(product[0],product[1])
        quantity =  product[4].to_i - 1
        product[4] = quantity.to_s
        puts "order has been placed successfully"
        new_data << product
      elsif product[0].to_i == i && product[4].to_i < 1
        puts "Out of stock"
        new_data << product
      else
        new_data << product
      end
      update_data(new_data)
    end
  end

  def place_order(id , name )
    card_no = user_input("card Number")
    cvv = user_input( "cvv")
    order_details = [ id ,name,card_no,cvv ]
    append(to_line(order_details), "order.txt")
  end
end






