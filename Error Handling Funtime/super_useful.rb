# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue TypeError => e
    return nil
  end
  Integer(str)
end

# PHASE 3
class NotAFavorite < StandardError
end

class EnteredCoffee < StandardError
end

FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise EnteredCoffee.new("feed me another fruit")
  else 
    raise NotAFavorite
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue EnteredCoffee => e
    puts e.message
    retry
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    unless yrs_known >= 5
      raise ArgumentError.new("Can't be bestie unless years known is longer than 5")
    end
    unless name.length > 0
      raise ArgumentError.new("Can't be bestie unless they have a name")
    end
    unless fav_pastime.length > 0
      raise ArgumentError.new("Can't be bestie unless favorite pastime")
    end
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end