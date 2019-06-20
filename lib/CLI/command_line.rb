# frozen_string_literal: true

class CLI
  def welcome
    system 'clear'
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts ' '
    puts '――――――――――――――――――――――---―――――――――――――――――――---------'
    puts pastel.bold('Welcome to Headquarters! Please log in or create a username.')
    prompt = TTY::Prompt.new
    prompt.select('') do |menu|
      menu.choice 'Login', -> { login }
      menu.choice 'Create a username', -> { create_username }
      menu.choice 'Exit', -> { exit }
    end
    end

  def login
    system 'clear'
    puts ''
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold('Welcome back! Please enter your username.')
    puts ''
    name = gets.chomp
    if User.exists?(username: name)
      @user = User.find_by(username: name)
      puts ''
      system 'clear'
      main_menu
    else
      system 'clear'
      puts ''
      puts pastel.bold("We're sorry, we can't find that username.")
      puts ''
      failed_login
    end
  end

  def failed_login
    system 'clear'
    puts ''
    puts 'Please try entering it again.'
    puts ''
    answer = gets.chomp
    if answer = User.exists?(username: answer)
      puts ''
      puts 'Login success!'
      puts ''
      main_menu
    elsif
      system 'clear'
      try_again
    end
  end

  def try_again
    prompt = TTY::Prompt.new
    prompt.select("We're sorry, we couldn't find that username. Would you like to try again or create a new username?") do |menu|
      menu.choice 'Try again', -> { failed_login }
      menu.choice 'Create username', -> { create_username }
    end
  end

  def create_username
    system 'clear'
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts ''
    puts pastel.bold('                    CREATE USER')
    puts '――――――――――――――――――――――――――――――――――――――――――---------'
    puts "Please type in the username you'd like to create."
    puts ''
    new_name = gets.chomp
    @user = User.create(username: new_name)
    puts ''
    puts "Welcome, #{new_name}!"
    puts ''
    main_menu
  end

  def main_menu
    system 'clear'
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold('          Main Menu')
    puts '―――――――――――――――――――――――――――-'
    prompt = TTY::Prompt.new
    prompt.select('Please select a menu option.') do |menu|
      menu.choice 'Search for companies', -> { search_menu }
      menu.choice 'See your favorites', -> { see_favorites }
      menu.choice 'Exit Headquarters', -> { exit }
    end
  end

  def search_menu
    system 'clear'
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold('          Search Menu')
    puts '―――――――――――――――――――――――――――-'
    prompt = TTY::Prompt.new
    prompt.select('Please select a menu option.') do |menu|
      menu.choice 'Search for companies by location', -> { find_companies_by_location }
      menu.choice 'Search for companies by keyword', -> { find_companies_by_description }
      menu.choice 'Go back to main menu', -> { main_menu }
    end
  end

  def find_companies_by_location
    system 'clear'
    puts ''
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold("Please enter the city you'd like to work in") + ' (example: Palo Alto).'
    puts ''
    city = gets.chomp
    puts ' '
    if Company.exists?(location: city)
      city_match = Company.where location: city
      company_names = city_match.map(&:name)
      company_names.each do |company|
        puts company
      end
      puts '--------------------------------------------------------------------------------'
      puts pastel.bold("There are #{company_names.count} companies that have offices in #{city}!")
      puts '--------------------------------------------------------------------------------'
      company_menu 
    else
      prompt.select("We're sorry, there are no jobs in #{city}. Please try again or select another option.") do |menu|
        menu.choice 'Search for companies by location', -> { find_companies_by_location }
        menu.choice 'Search for companies by keyword', -> { find_companies_by_description }
        menu.choice 'Go back to main menu', -> { main_menu }
      end
    end
  end

  def find_companies_by_description
    system 'clear'
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts 'Please enter a keyword'
    keyword = gets.chomp
    company_existence = Company.all.select do |company|
      company.description.include?(keyword)
    end
    if company_existence.count > 0
      company_existence.map do |company|
        puts pastel.bold("#{company.name.to_s}:  ") + "#{company.description}"
      end
      puts pastel.bold('What would you like to do next?')
        prompt.select(' ') do |menu|
          menu.choice 'Save a company to your favorites', -> { save_company }
          menu.choice 'Start a new search', -> { search_menu }
          menu.choice 'Exit to main menu', -> { main_menu }
        end
    else
      prompt.select("We're sorry, there are no companies with descriptions that contain #{keyword}. Please try again or select another option.") do |menu|
        menu.choice 'Search for companies by location', -> { find_companies_by_location }
        menu.choice 'Search for companies by keyword', -> { find_companies_by_description }
        menu.choice 'Go back to main menu', -> { main_menu }
      end
    end
  end

  def company_menu
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold('What would you like to do next?')
      prompt.select(' ') do |menu|
        menu.choice 'Learn more about a company', -> { see_descriptions }
        menu.choice 'Save a company to your favorites', -> { save_company }
        menu.choice 'Start a new search', -> { find_companies_by_location }
        menu.choice 'Exit to main menu', -> { main_menu }
      end
  end

  def see_descriptions
    puts ''
    puts "If you'd like to learn more about a company, please enter its name. Otherwise, type exit to return to the menu."
    puts ''
    response = gets.chomp
    if response == 'exit'
      main_menu
    elsif Company.exists?(name: response)
      company_match = Company.where name: response
      company_description = company_match.map do |company|
        company.description
      end
      puts ''
      prompt = TTY::Prompt.new
      pastel = Pastel.new
      puts pastel.bold("Here's a little bit more about #{response}:")
      puts '--------------------------------------------------------------------------------'
      puts company_description
      puts '--------------------------------------------------------------------------------'
      puts ''
      puts pastel.bold('What would you like to do next?')
        prompt.select(' ') do |menu|
          menu.choice 'Learn more about another company', -> { see_descriptions }
          menu.choice 'Save this to your favorites', -> { save_company }
          menu.choice 'Start a new search', -> { find_companies_by_location }
          menu.choice 'Exit to main menu', -> { main_menu }
        end
    else
      puts ''
      puts "We're sorry, there are no companies that match the name #{response}. Please try again."
      puts ''
      see_descriptions
    end
  end

  def save_company
    puts ''
    puts "Please enter the name of the company you'd like to save. Otherwise, type exit to return to the main menu."
    puts ''
    response = gets.chomp
    if response == 'exit'
      main_menu
    elsif Company.exists?(name: response)
      company_match = Company.where name: response
      company_matches = company_match.find(&:id)
      @user.favorites << Favorite.create(user: @user, company: company_matches)
      puts ''
      puts "Thanks! #{response} has been saved to your favorites."
      puts ''
      save_company
    else
      puts ''
      puts "We're sorry, there are no companies that match the name #{response}. Please try again."
      puts ''
      save_company
    end
  end

  def see_favorites
    system 'clear'
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold 'Your Saved Companies'
    puts '-------------------------'
    company_matches = Company.where id: @user.favorites.map(&:company_id)
    if company_matches.count == 0
      # puts ''
      puts 'You have no favorites yet! Add some by searching for some companies.'
      puts ''
      prompt.select(' ') do |menu|
        menu.choice 'Return to Main Menu', -> { main_menu }
      end
    else
      company_matches.map do |company|
        puts company.name
      end
      favorite_options
    end
  end

  def favorite_options
    puts ' '
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    puts pastel.bold('What would you like to do next?')
    prompt = TTY::Prompt.new
    prompt.select(' ') do |menu|
      menu.choice 'Search for more companies', -> { find_companies_by_location }
      menu.choice 'Delete favorite', -> { delete_favorites }
      menu.choice 'Return to main menu', -> { main_menu }
    end
  end

  def delete_favorites
    prompt = TTY::Prompt.new
    puts "Enter the company name you want to delete."
    response = gets.chomp
    selected_company = Company.find_by name: response
    selected_company.delete
    see_favorites
    puts "Company deleted!"
    prompt.select(' ') do |menu|
      menu.choice 'Return to Main Menu', -> { main_menu }
    end
  end

end # end of class method
