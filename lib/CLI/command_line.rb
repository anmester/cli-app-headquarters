class CLI
    def welcome
        puts "Welcome to HQ! Please create a username."
        name = gets.chomp
        @user = User.create(username: name)
        puts "Welcome, #{name}!"
    end

    def get_location
        puts "Please enter the city you'd like to work in."
        city = gets.chomp
        city_match = Company.where location: city
        company_names = city_match.map do |company|
            company.name
        end
        company_names
        binding.pry
    end

    # def say_names
    #     puts "These are the companies that have offices in your city."
    # end

    def save_companies
        puts "Would you like to save any of these companies? Please enter the name of the first company you'd like to save."
        company_name = gets.chomp
        company_match = Company.where name: company_name
        company_matches = company_match.find do |company|
            company.id
        end
        Favorite.create(user: @user, company: company_matches)
        puts "Thanks! #{company_name} has been saved to your favorites."
    end

    def see_favorites
    end
end 
