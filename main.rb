
# Подключаем парсер для XML
require 'rexml/document'

require_relative 'product'
require_relative 'book'
require_relative 'disk'
require_relative 'movie'

total_price = 0

# Все что мы поменяем, это то, как мы получаем массив продуктов
# Раньше мы генерировали его руками, теперь этим будет заниматься статический метод
# read_form_xml, которому мы будем передавать относительный путь к файлу
products = Product.read_from_xml('data/products.xml')

choice = nil

while choice != 'x'
  Product.showcase(products)

  choice = STDIN.gets.chomp

  if choice != 'x' && choice.to_i < products.size && choice.to_i >= 0
    product = products[choice.to_i]
    total_price += product.buy
  end
end

puts "Спасибо за покупки, с Вас #{total_price} руб."
