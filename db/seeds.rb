# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Room.create(name: 'Shawnas Room Test', owner_id: 1)
Track.create(room_id: 1, spotify_url: "spotify:track:4qKcDkK6siZ7Jp1Jb4m0aL")
Track.create(room_id: 1, spotify_url: "spotify:track:2G7V7zsVDxg1yRsu7Ew9RJ")
Track.create(room_id: 1, spotify_url: "spotify:track:6vN77lE9LK6HP2DewaN6HZ")
Track.create(room_id: 1, spotify_url: "spotify:track:04MLEeAMuV9IlHEsD8vF6A")
Track.create(room_id: 1, spotify_url: "spotify:track:3CA9pLiwRIGtUBiMjbZmRw")
