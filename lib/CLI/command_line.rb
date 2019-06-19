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
            @user = User.find_by(username: name)
            puts "Welcome, #{name}!"
            main_menu
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
            main_menu
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
            puts "We're sorry, we didn't understand that. Please type 1 to try again or 2 to create a username."
            try_again
        end
    end

    def create_username
        puts "Please create a username."
        new_name = gets.chomp
        @user = User.create(username: new_name)
        puts "Welcome, #{new_name}!"
        main_menu
    end

    def main_menu
        puts "Please type 1 or 2 to continue."
        puts "1. Search for companies"
        puts "2. See your favorites"
        answer = gets.chomp
        if answer == "1"
            get_location
        elsif answer == "2"
            see_favorites
        else
            puts "We're sorry, that's not an option."
            main_menu
        end
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
        puts "These are the companies that have offices in #{city}! Would you like to save any of these companies?"
        save_company
    end

    def save_company
      puts "Please enter the name of the company you'd like to save. Otherwise, type exit to return to the menu."
      response = gets.chomp
        if response == "exit"
          main_menu
        else
          company_match = Company.where name: response
          company_matches = company_match.find do |company|
            company.id
          end
          @user.favorites << Favorite.create(user: @user, company: company_matches)
          puts "Thanks! #{response} has been saved to your favorites."
          save_company
        end
    end


    def see_favorites
      fav_companies = @user.favorites.map do |favorite|
          favorite.company_id
      end
      company_matches = Company.where id: fav_companies
      company_match_names = company_matches.map do |company|
          puts company.name
      end

    end


end # end of class method
