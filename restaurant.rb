require 'terminal-table'
class MenuItem
  def initialize(name, description, price)
    @name = name
    @description = description    
    @price = price
  end
  attr_accessor :name, :price, :description
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
    @items.each do |x|
      total += x.price
    end
    "$#{total.round(2)}"
  end
  def total_credit
    total = 0
    surcharge = 0
    @items.each do |x|
      total += x.price
      surcharge = total * (1.5/100)
      total = total + surcharge 
    end
    "$#{total.round(2)} (includes credit surcharge of $#{surcharge.round(2)})"
  end
  def bill
    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |x|
        t << [x.name,  "$#{x.price}"]
      end
      t.add_separator
      t << ['TOTAL', total]
    end
    table
  end
  def bill_credit
    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |x|
        t << [x.name,  "$#{x.price}"]
      end
      t.add_separator
      t << ['TOTAL', total_credit]
    end
    table
  end
end
ENTREE_ITEMS = [
  MenuItem.new('CROQUETTES DE LÉGUMES', 'petits pois, broad bean & herb croquettes with aïoli and watercress', 11.95),
  MenuItem.new('SALMON RILLETTES', 'smoked & poached sustainable salmon rillettes with pickled fennel and chargrilled sourdough bread', 13.45),
  MenuItem.new('SOUPE DE SAISON','made to our own recipe, served with a wedge of rye & caraway bread', 15.95),
  MenuItem.new('CAMEMBERT','warm breaded Camembert with cranberry & redcurrant sauce', 7.85),
  MenuItem.new('FOUGASSE À L\'AIL','artisanal garlic sharing bread made to a traditional leaf design, with warm garlic butter', 9.50),
  MenuItem.new('PLATEAU DE PAIN','chargrilled sourdough bread, wedge of rye & caraway bread and classic baguette with plain and Café de Paris butter', 8.50)
]
MAIN_ITEMS = [
  MenuItem.new('TAGINE','Harissa and coriander, finished with toasted almonds and chilli & coriander chutney. Served with Mediterranean khobez flatbread',45.95),
  MenuItem.new('BOEUF BOURGUIGNON','sustainably sourced sea bream, salmon, mussels and king prawns cooked to a traditional recipe in a tomato & saffron broth, served with baguette', 55.95),
  MenuItem.new('DEMI POULET','half roast chicken marinated in garlic & herbs, served with thyme jus and frites', 45.50),
  MenuItem.new('MOULES','fresh, sustainably grown mussels steamed to order in cream, garlic, celery & white wine, with frites', 37.95),
  MenuItem.new('CRÊPE AU FOUR','baked crêpe filled with Portobello and chestnut mushrooms, spinach, shallots, garlic, Emmental cheese and a Mornay & cèpe sauce, with frites or house salad', 27.95),
  MenuItem.new('SAUMON','baked sustainably sourced salmon fillet with buttered spinach, new potatoes, croutons, lemon and beurre noisette', 35.50)
]
DESERT_ITEMS = [
  MenuItem.new('MOUSSE AU CHOCOLAT','French chocolate mousse made with luxury Valrhona chocolate', 19.50),
  MenuItem.new('CRÈME BRÛLÉE','caramelised vanilla crème with an almond tuile', 32.50),
  MenuItem.new('ETON MESS','fresh raspberries & strawberries, with vanilla ice cream, strawberry sorbet, crushed meringue and strawberry coulis', 18.95),
  MenuItem.new('RASPBERRY PARFAIT','smooth raspberry parfait with white chocolate sauce and salted caramel pistachios', 25.50),
  MenuItem.new('STRAWBERRY CHEESECAKE','baked vanilla cheesecake with fresh strawberries and strawberry coulis', 34.95),
  MenuItem.new('TARTE AUX POMMES','warm apple tart with tarte tatin ice cream', 35.50)
]
DRINKS_ITEMS = [
  MenuItem.new('KIR ROUGE','Prosecco with a touch of mixed berries', 8.99),
  MenuItem.new('ROUGE MIMOSA','Prosecco and fresh orange juice', 15.50),
  MenuItem.new('PEACH POMPETTE','Absolut vodka, peach iced tea and lemon', 16.95),
  MenuItem.new('BERRY PUNCH','Absolut vodka, raspberry, elderberry, blackberry and lime', 17.50),
  MenuItem.new('LA MARTINIQUE','Havana Club Especial rum, elderflower,lemonade', 7.99),
  MenuItem.new('FIZZ LA POIRE','Absolut Pears vodka, cloudy apple juice, elderflower and lemonade', 13.50)
]
def display(items_array)
    items_array.each_with_index do |menu_item, index|
      user_index = index + 1
      puts "#{user_index}. #{menu_item.name} - #{menu_item.description}\n"
    end 
end

def order_food(items, order)
    menu_item = nil
    loop do    
    display(items)
    puts "\n\nYou ordered #{menu_item.name}." if menu_item != nil
    puts "\n\nWhat would you like?\n Press a number corresponding to menu item or press enter to exit."       
    choice = gets.chomp
    break if choice == ""
    user_index = choice.to_i
    index = user_index - 1 
    menu_item = items[index]
    order << menu_item
    end
end

myorder = Order.new

loop do
  puts "\nWELCOME TO CAFE\' A\' LA\' ROUGE \n Choose from the options below by entering a corresponding number or press enter to exit:\n1. Show food menu\n2. Ask for bill\n"
  choice = gets.chomp
  break if choice == ""
  user_index = choice.to_i

  if user_index == 1
    loop do 
      puts "\n\nOur menu has an exquisite assortment of \nthe finest meals in french cuisine. Choose from the \noptions below by entering a corresponding number \nor press enter to exit:\n\n\n1. Show entree menu\n2. Show main menu\n3. Show desert menu\n4. Show drinks menu\n" 
      choice = gets.chomp  
      break if choice == ""
      user_index = choice.to_i

      if user_index == 1
        order_food(ENTREE_ITEMS, myorder)
      end

      if user_index == 2
        order_food(MAIN_ITEMS, myorder)
      end

      if user_index == 3
        order_food(DESERT_ITEMS, myorder)
      end

      if user_index == 4
        order_food(DRINKS_ITEMS, myorder)
      end  
    end
  end    

  if user_index == 2 
     puts myorder.bill
  end
end

loop do
  choice = nil
  break if choice != nil
  puts "Thank you for dining at CAFE\' A\' LA\' ROUGE. Press '1' if you'd like to pay with cash or '2' for a credit card payment?"
  choice = gets.chomp().to_i
  if choice == 1
  puts 'I hope you enjoyed your meal. Here is your receipt:'
  puts myorder.bill 
  break
  end
  if choice == 2
  puts 'Credit cards incur a surcharge of 1.5%. '
  puts 'Processing payment. Please wait...'
  sleep 2 
  puts 'I hope you enjoyed your meal. Here is your receipt:'
  puts myorder.bill_credit
  break
  end
end