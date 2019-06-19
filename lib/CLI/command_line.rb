class CLI
    def welcome
        puts "Welcome to HQ! Please type 1 to log in or 2 to create a username."
        answer = gets.chomp
        if answer == "2"
            create_username
        elsif answer == "1"
            login
        else
            puts "We're sorry, we didn't understand that command."
            welcome
        end
    end

    def login
        puts "Welcome back! Please enter your username."
        name = gets.chomp
        if User.exists?(username: name)
            puts "Welcome, #{name}!"
        else 
            puts "We're sorry, we can't find that username."
            failed_login
        end
    end

    def failed_login
        puts "Please try entering it again."
        answer = gets.chomp
        if answer = User.exists?(username: answer) 
            puts "Login success!"
        elsif
            try_again
        end
    end

    def try_again
        puts "Type 1 to try again or 2 to create a username."
        new_answer = gets.chomp
        if new_answer == "1"
            failed_login
        elsif new_answer == "2"
            create_username
        else
            "We're sorry, we didn't understand that. Please type 1 to try again or 2 to create a username."
            try_again
        end
    end

    def create_username
        puts "Please create a username."
        new_name = gets.chomp
        User.create(username: new_name)
        puts "Welcome, #{new_name}!"
    end
        

    def get_location
        puts "Please enter the city you'd like to work in."
        city = gets.chomp
        city_match = Company.where location: city
        company_names = city_match.map do |company|
            company.name
        end
        company_names.each do |company|
            puts company
        end
        puts "These are the companies that have offices in #{city}!"
    end

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
