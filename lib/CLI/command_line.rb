class CLI
    def welcome
        prompt = TTY::Prompt.new
        prompt.select("Welcome to HQ! Please log in or create a username.") do |menu|
            menu.choice 'Login', -> {login}
            menu.choice 'Create a username', -> {create_username}
        end
    end

    def login
        puts ""
        puts "Welcome back! Please enter your username."
        puts ""
        name = gets.chomp
        if User.exists?(username: name)
            @user = User.find_by(username: name)
            puts ""
            puts "Welcome, #{name}!"
            puts ""
            main_menu
        else
            puts ""
            puts "We're sorry, we can't find that username."
            puts ""
            failed_login
        end
    end

    def failed_login
        puts ""
        puts "Please try entering it again."
        puts ""
        answer = gets.chomp
        if answer = User.exists?(username: answer)
            puts ""
            puts "Login success!"
            puts ""
            main_menu
        elsif
            try_again
        end
    end

    def try_again
        prompt = TTY::Prompt.new
        prompt.select("Would you like to try again or create a new username?") do |menu|
            menu.choice 'Try again', -> {failed_login}
            menu.choice 'Create username', -> {create_username}
        end
    end

    def create_username
        puts ""
        puts "Please type in the username you'd like to create."
        puts ""
        new_name = gets.chomp
        @user = User.create(username: new_name)
        puts ""
        puts "Welcome, #{new_name}!"
        puts ""
        main_menu
    end

    def main_menu
        prompt = TTY::Prompt.new
        prompt.select("Please select a menu option.") do |menu|
            menu.choice 'Search for companies', -> {get_location}
            menu.choice 'See your favorites', -> {see_favorites}
            menu.choice 'Exit HQ', -> {exit}
        end
    end

    def get_location
        puts ""
        puts "Please enter the city you'd like to work in."
        puts ""
        city = gets.chomp
        if Company.exists?(location: city)
            city_match = Company.where location: city
            company_names = city_match.map do |company|
                company.name
            end
            company_names.each do |company|
                puts company
            end
            puts ""
            puts "These are the companies that have offices in #{city}! Would you like to save any of these companies?"
            puts ""
            save_company
        else
            puts ""
            puts "We're sorry, there are no jobs in #{city}. Please try again."
            puts ""
            get_location
        end
    end

    def save_company
        puts ""
        puts "Please enter the name of the company you'd like to save. Otherwise, type exit to return to the menu."
        puts ""
      response = gets.chomp
        if response == "exit"
            main_menu
        elsif Company.exists?(name: response)
            company_match = Company.where name: response
            company_matches = company_match.find do |company|
                company.id
            end
            @user.favorites << Favorite.create(user: @user, company: company_matches)
            puts ""
            puts "Thanks! #{response} has been saved to your favorites."
            puts ""
            save_company
        else
            puts ""
            puts "We're sorry, there are no companies that match the name #{response}. Please try again."
            puts ""
            save_company
        end
    end

    def see_favorites
        fav_companies = @user.favorites.map do |favorite|
            favorite.company_id
        end
        company_matches = Company.where id: fav_companies
        if company_matches.count == 0
            puts ""
            puts "You have no favorites yet! Add some by searching for some companies."
            puts ""
            main_menu
        else
            puts ""
            puts "These are your matches:"
            puts ""
            company_matches.map do |company|
                puts company.name
            end
            favorite_options
        end
    end

    def favorite_options
        prompt = TTY::Prompt.new
        prompt.select("What would you like to do next?") do |menu|
            menu.choice 'Search for more companies', -> {get_location}
            menu.choice 'Return to main menu', -> {main_menu}
        end
    end

end # end of class method
