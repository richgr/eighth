
namespace :db do

  desc "Fill database with sample data" 

  if RAILS_ENV == 'development'
    task :populate => :environment do
      Rake::Task['db:reset'].invoke
      admin = User.create!( :name => "Example User",
                    :email => "email@railstutorial.org",
                    :password => "foobar",
                    :password_confirmation => "foobar")
      admin.toggle!(:admin)

      require 'faker'

      99.times do |n|
        name = Faker::Name.name
        email = "example-#{n+1}@railstutorial.org"
        password = "football"
        User.create!( :name => name,
                      :email => email,
                      :password => password,
                      :password_confirmation => password)    
      end
      
      50.times do
        User.all(:limit => 6).each do |user|
          user.microposts.create!(:content => Faker::Lorem.sentence(5))
        end
      end
    end
  end
end
