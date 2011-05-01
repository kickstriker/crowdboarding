namespace :db do
  desc "Erase and fill database with dummy data"
  task :fill_database => :environment do
    require 'populator'
    require 'faker'
    
    [Event, User].each(&:delete_all)    
    
    User.populate 100 do |user|
      user.name = Faker::Name.name
      user.email = Faker::Internet.email
      user.encrypted_password = "bleh :)"
    end
    
    Event.populate 100 do |event|
      event.name = Populator.words(1..3).titleize
      event.created_at = 2.years.ago..Time.now
        event.starts_at = 1.weeks.ago..1.weeks.from_now
      event.user_id = (rand * User.count).to_i
      event.description = Populator.paragraphs(1..3)
      event.address = Faker::Address.street_address
      event.lat = (rand(-100000) / -100000.0)
      event.lng = (rand(-100000) / -100000.0)
      event.users_count = 1..40
    end
  end
end