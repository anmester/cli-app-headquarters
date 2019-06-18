
def welcome
    puts "Welcome to HQ! Please input your username."
    name = gets.chomp
    User.create(username: name)
    puts "Welcome back, #{username}!"
end

def get_location
    puts "Please enter the city you'd like to work in."
    city = gets.chomp
    city_match = Company.where location: city
    company_names = city_match.map do |company|
        company.name
    end
    puts "Here are the companies that have offices in the city you requested:"
    company_names
end

