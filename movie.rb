class Movie < Product
  def update(options)
    @title = options[:title]
    @directort_name = options[:directort_name]
    @year = options[:year]
  end

# Для фильма метод info возвращает строку с названием фильма, режисером и годом выпуска
  def info
    "Фильм #{@title}, реж. #{@directort_name} #{@year}"
  end
end