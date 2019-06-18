
def welcome
    puts "Welcome to HQ! Please create a username."
    name = gets.chomp
    User.create(username: name)
    puts "Welcome, #{username}!"
end

def get_location
    puts "Please enter the city you'd like to work in."
    city = gets.chomp
    city_match = Company.where location: city
    company_names = city_match.map do |company|
        company.name
    end
    puts "Here are the companies that have offices in #{city}:"
    company_names
end

def save_companies
end

