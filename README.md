# Dr Dolittle's Vet Management App

This project is a Vet Management App created by Ashir Qureshi for his CodeClan individual project.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

What things you need to install the software and how to install them:


1. You will need to install PostGreSQL to carry out database queries:
```
gem install pg
```

2. You will also need Sinatra installed to create a local server for the web interface:
```
gem install sinatra
```

### Installing

A step by step series of examples that tell you how to get a development env running

1. Create a database called 'vetpractice' using psql:
```
createdb vetpractice
```

2. Run the vetpractice SQL file in the newly created database:
```
psql -d vetpractice -f db/vetpractice.sql
```

3. Now seed the database with the included seed file:
```
ruby db/seed.rb
````


## Running the App

To run the app use the followin command:
```
ruby app.rb
```


## Built With

* [Ruby](http://www.ruby-lang.org) - The programming language used for logic/interface
* [PSQL](https://www.postgresql.org/) - Database management
* [Sinatra](https://sinatrarb.com) - To create a local web server


## Authors

* **Ashir Qureshi** - [Ashmanq](https://github.com/Ashmanq)

## Acknowledgments

* The CodeClan team
* My fellow G18 cohort
