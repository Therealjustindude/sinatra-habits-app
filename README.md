# Habitual Habits

This is a web application I created as a Flatiron School of Engineering student, as part of the SQL/ActiveRecord/ORM/MVC/Sinatra module.

Habitual Habits is a Model-View-Controller Sinatra application that allows a user to sign up, log in, create a habit, read/view their habits, edit their habits, and delete their habits (CRUD).

## Getting Started

### Installing

- Fork and clone repo to your local machine.
- Use ```bundle install``` to install dependencies.
- create a .env file and add this ```SESSION_SECRET = Sysrandom.base64(32)```
- create a .gitignore and add both ```.env``` and 
```db/development.sqlite``` to the file 

### Usage

- Change directories into this application
- Run ```rake db:mirgrate``` from the command line
- Run ```shotgun``` from the command line 
- Go to your browser and enter ```localhost:9393``` into your search bar to view the application.

## Built With
* [sinatra-flash](https://github.com/SFEley/sinatra-flash)
* [Corneal](https://github.com/thebrianemory/corneal)
* [dotenv](https://github.com/motdotla/dotenv)
* [sysrandom](https://github.com/cryptosphere/sysrandom)
* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

