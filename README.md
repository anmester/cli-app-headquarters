# HQ - a Command Line CRUD App

Welcome to HQ! With this CLI app, you are able to log in, search the Crunchbase database to find companies by location or keyword, and save chosen companies to a favorites list. You're also able to delete any favorites you may not want to save anymore, access favorites to review, and learn more about any company by selecting that option.

## Installation

1. Run bundle install to install all gems in the gemfile.
2. In the \bin\run.rb file, change the organizations.csv path to the full file path on your computer - example below. Find the full filepath by navigating to /db/organizations.csv and right-clicking on the filename then selecting 'Copy Path'. Do not copy the relative path - only the full path will work.
    # CSV.foreach('INSERT YOUR FULL FILEPATH TO ORGANIZATIONS.CSV', headers: true) do |row|
    #     Company.create(name: row[1], location: row[12], description: row[15])
    # end
3. Once the appropriate full path to the organizations.csv file has been added to the command, un-comment out the command (lines 5-7).
4. Comment out lines 10 & 12 in the same /bin/run.rb.
5. Next, navigate to your terminal and enter 'ruby bin/run.rb' to populate the Company table with the CSV data.
6. Once the program stops running, comment out lines 5-7 and comment lines 10 & 12 back in.
7. Program should run as designed when calling /run.rb.

## Usage

To start the program, run 'ruby bin/run.rb in your terminal. Navigate through each menu using the up/down arrow keys. All inputs must be in proper case.

## Contributors Guide

Pull requests are welcome - we'd love for you to contribute. If you're planning to write any large-scale changes, please open an issue first to discuss your proposed changes.

## License

Please see LICENSE file.
