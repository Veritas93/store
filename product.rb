class Product
  def initialize(price, amount)
    @price = price
    @amount_available = amount
  end

  def price
    @price
  end

  def update(options)
  end

  def info
  end

  def show
    "#{info} - #{@price} руб. [осталось: #{@amount_available}]"
  end

  def self.showcase(products)
    puts "Что хотите купить?\n\n"

    products.each_with_index do |product, index|
      puts "#{index}: #{product.show}"
    end

    puts "x. Покинуть магазин\n\n"
  end

  def buy
    if @amount_available > 0
      puts "* * *"
      puts "Вы купили товар #{info}"
      puts "* * *\n\n"

      @amount_available -= 1
      price
    else 
      puts "К сожалению, больше нет"
      0
    end
  end

  def self.read_from_xml(file_name)
    # Получим абсолютный путь к файлу
    file_path = File.dirname(__FILE__) + "/" + file_name
    # Если файла нет, сразу закончим выполнение программы, сообщив об этом 
    unless File.exist?(file_path)
      abort "Файл #{file_path} не найден"
    end

    # Открываем файл и передаем его в парсер
    file = File.new(file_path, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close
    
    # Две временные переменные, которые мы будем использовать дальше
    result = []
    product = nil

    # Найдем все теги product, которые лежат внутри корневого тега products
    doc.elements.each("products/product") do |product_node|
      # из атрибутов каждого тега достанем цену и количество на складе
      price = product_node.attributes["price"].to_i
      amount_available = product_node.attributes["amount_available"].to_i

      # По правилам формирования нашего файла в каждом теге product 
      # Может быть только один элемент book, movie, disk
      # таким образом в два из этих  цикла мы не зайдем
      product_node.each_element("book") do |book_node|
      # сейчас внутри тега book 
      # и можем прочитать его атрибуты и создать соответствующий класс
        product = Book.new(price, amount_available)
        product.update(
          title: book_node.attributes["title"],
          author_name: book_node.attributes["author_name"]
        )
      end

      product_node.each_element("movie") do |movie_node|
      # сейчас внутри тега movie 
      # и можем прочитать его атрибуты и создать соответствующий класс
        product = Movie.new(price, amount_available)
        product.update(
          title: movie_node.attributes["title"],
          director_name: movie_node.attributes["director_name"],
          year: movie_node.attributes["year"]
        )
      end

      product_node.each_element("disk") do |disk_node|
      # сейчас внутри тега disk 
      # и можем прочитать его атрибуты и создать соответствующий класс
        product = Disk.new(price, amount_available)
        product.update(
          album_name: disk_node.attributes["album_name"],
          artist_name: disk_node.attributes["artist_name"],
          genre: disk_node.attributes["genre"]
        )
      end

      # Теперь запишем созданный экземпляр класса в результирующий массив
      # и прейдем к следующему тегу product
      result.push(product)
    end

    # Вернем массив продутков
    return result
  end 
end
