# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    cages = Cage.create([
      { 
        size: 10.5, 
        category: 'bird-cage', 
        name: 'Bird Cage',  
        latitude: 10.122,  
        longitude: 13.219,  
        human_present: false,  
        animal_name: 'Flamingo',  
        date_last_fed: Time.now,
        date_last_cleaned: Time.now
      }, 
      { 
        size: 12, 
        category: 'safari', 
        name: 'Lion Pit',  
        latitude: 10.1202,  
        longitude: 13.202,  
        human_present: true,  
        animal_name: 'Lion',  
        date_last_fed: Time.now
      }
    ])

    entrance_one = cages.first.entrances.create({})
    entrance_two = cages.last.entrances.create({})

    entrance_one.doors.create([
      {
        open: true
      },
      {
        open: false
      },
      {
        open: true
      }
    ])
    entrance_two.doors.create([
      {
        open: true 
      },
      {
        open: true
      }
    ])
