# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database"
Message.destroy_all
Contact.destroy_all
Employee.destroy_all

puts "Add employees"
Employee.create(
  name: "Jean-François",
  job_title: "Gérant",
  about: "Lauréat du prix BELIN en 1982, CNDB :Maison Bois Outil Concept, Conseiller Européen en Maisons Passives (Certific
  ation Européenne de Passiv Haus : La Maison Passive)"
)
Employee.create(
  name: "Evelyne",
  job_title: "Assistante de direction",
  about: "DUT animation socio-culturel"
)
Employee.create(
  name: "Hugo",
  job_title: "Ingénieur",
  about: "CAP de charpente, BTS SCBH (Systèmes Constructifs Bois et Habitat), Ingénieur Génie Civil bois"
)
Employee.create(
  name: "Vincent",
  job_title: "Technicien",
  about: "CAP de charpente, BTS SCBH (Systèmes Constructifs Bois et Habitat), Licence professionnelle Bâtiments Bois Basse Co
nsommation et Passifs 2018-2019, Licence professionnelle métiers de l’entreprenariat parcours TPE"
)
Employee.create(
  name: "Sébastien",
  job_title: "Opérateur centre d'usinage à commande numérique",
  about: "BTS SCBH (Systèmes Constructifs Bois et Habitat)"
)
puts "#{Employee.count} employees have been created"
puts "Database ready"