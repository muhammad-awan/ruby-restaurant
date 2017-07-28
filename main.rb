require 'terminal-table'

class MenuItem
  def initialize(name, price)
    @name = name
    @price = price
  end

  attr_accessor :name, :price
end


class Order
  def initialize()
    @items = []
  end

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @items.each do |item|
      total += item.price
    end
    "$#{total}"
  end

  def bill
    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |item|
        t << [item.name, "$#{item.price}"]
      end
      t.add_separator
      t << ['TOTAL', total]
    end
    table
  end
end


MENU_ITEMS = [
  MenuItem.new('Steak', 20),
  MenuItem.new('Parma', 15),
  MenuItem.new('Eggplant Casserole', 15),
  MenuItem.new('Chips', 7),
  MenuItem.new('Beer', 7),
  MenuItem.new('Soft drink', 3.50)
]

Show food menu
Order items
Ask for bill

# Display menu
MENU_ITEMS.each_with_index do |menu_item, index|
  user_index = index + 1
  # Display item with index first, then name and price
  puts "#{user_index}. #{menu_item.name}: #{menu_item.price}"
end

order = Order.new

loop do
  puts 'What would you like to do?'
  choice = gets.chomp
  # Stop looping if user pressed just enter
  break if choice == ""

  # User must choose an index number
  user_index = choice.to_i

  # If the user entered in an invalid choice
  if user_index == 0
    "Invalid choice, please try again"
    next # Loop through and ask again
  end

  index = user_index - 1 # Convert to zero-based index
  menu_item = MENU_ITEMS[index]

  # Add item to order
  order << menu_item
end

puts 'Thank you'
puts ''

sleep 2
puts 'I hope you enjoyed your meal. Here is your bill:'
puts order.bill