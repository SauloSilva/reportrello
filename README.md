#### Getting Started

1. bundle install
2. shotgun -p 3000 -o 0.0.0.0
3. bundle exec sidekiq -r ./config/sidekiq.rb
3. Visit http://localhost:3000/ in your browser

#### Production

Visit [https://reportrello.herokuapp.com/](https://reportrello.herokuapp.com/)