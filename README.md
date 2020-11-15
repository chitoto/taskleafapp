* Ruby version
  ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin19]
  Rails 5.2.4.4
  psql (PostgreSQL) 12.4

#Model
##User
  name:string
  email:string
  password_digest:string

##Task
  task_title:string
  task_description:text
  limit:date
  user_id(foreign_key):integer

##Label
  label_name:string
  user_id(foreign_key):integer
  task_id(foreign_key):integer

#Heroku
https://task-leaf-k-app.herokuapp.com/
1. $ heroku login
1. heroku git:remote -a アプリurl
1. $ rails assets:precompile RAILS_ENV=production
1. git add -A
1. $ git commit -am "heroku_make it better"
1. $ git push heroku master
