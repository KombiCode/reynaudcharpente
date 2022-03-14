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
Skill.destroy_all
Zipcode.destroy_all
Activity.destroy_all

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

puts "Add skills"
Skill.create(
  title: "CHARPENTE",
  description: "C’est la compétence historique de l’entreprise. Des fermes en bois massif aux lamellés-collés de la fin du 20ème siècle, nous avons suivi l’évolution technologique sans perdre notre savoir-faire. C’est aujourd’hui une de nos grandes forces dans la rénovation de charpentes anciennes."
)
Skill.create(
  title: "COUVERTURE",
  description: "De la tuile au bac acier en passant par les tavaillons, nous sommes en capacité de couvrir votre toit en fonction de vos goûts et des contraintes des PLU. Nous disposons également de l’agrément pour l’étanchéité de toit terrasse – végétalisé ou pas- par membrane EPDM collée à froid."
)
Skill.create(
  title: "ZINGUERIE",
  description: "Pionnier en Isère, notre première M.O.B. date de 1982. Elle est toujours en parfait état. Nous avons acquis cette technique dans les années 1980 grâce a un voyage en Amérique du Nord complété par la formation Maison Bois Outil Concept du C.N.D.B. (Comité National pour le Développement du Bois) en 2002. En effet la structure d’une maison ossature bois est bien plus complexe qu’un montant de bois tous les 60 cm."
)
Skill.create(
  title: "MAISON OSSATURE BOIS (M.O.B.)",
  description: "Pionnier en Isère, notre première M.O.B. date de 1982. Elle est toujours en parfait état. Nous avons acquis cette technique dans les années 1980 grâce a un voyage en Amérique du Nord complété par la formation Maison Bois Outil Concept du C.N.D.B. (Comité National pour le Développement du Bois) en 2002. En effet la structure d’une maison ossature bois est bien plus complexe qu’un montant de bois tous les 60 cm."
)
Skill.create(
  title: "ISOLATION",
  description: "Avec la recherche de performances pour avoir des maison à basse consommation (B.B.C.) voire nulle, l’isolation et l’étanchéité à l’air sont des enjeux cruciaux pour les bâtiments d’aujourd’hui et de demain. Nous privilégions les isolants naturels comme la fibre de bois. En plus de ses capacités d’isolation du froid, la fibre de bois offre un confort d’été très appréciable dans la vallée du Grésivaudan grâce à son déphasage (vitesse de propagation de la chaleur liée à la nature et la masse du matériau)."
)
Skill.create(
  title: "EXTENSION & SURÉLÉVATION",
  description: "C’est l’un des domaines où la rapidité de chantier grâce à la technique ossature bois prend tout son sens. La préfabrication des éléments permet de limiter au minimum la durée des travaux. Le poids de la solution ossature bois -bien plus légère que les solutions maçonnées – est un grand avantage et permet d’agrandir quasiment toutes les maisons par le haut. Vous bénéficiez de volumes habitables en plus, sans avoir réduit votre jardin."
)
puts "#{Skill.count} skills have been created"


puts "Add zipcodes"
require 'json'

file = File.read('./codes_postaux.json')
object = JSON.parse(file, object_class: OpenStruct)

data_array = []
object.each { |elt|
  data = { cp: elt.cp,
           nc: elt.nc }
  data_array << data
}
uniq_data = data_array.uniq
uniq_data_sorted = uniq_data.sort_by { |elem| elem[:cp] }

uniq_data_sorted.each { |data|
  # For Heroku, rows are limited for 'Free' plan
  # so in this case, create just a few records for Zipcode table
  limited_seeds = ENV['HEROKU_SEEDS_LIMITED']
  create_code = true
  if limited_seeds && (data[:cp].to_i < 38150 || data[:cp].to_i > 38190)
    create_code = false
  end
  if create_code
    Zipcode.create(
      code: data[:cp],
      name: data[:nc]
    )
  end
}

puts "#{Zipcode.count} zipcodes have been created"

puts "Add activities"
Activity.create(
  name: "Avant Projet"
)
Activity.create(
  name: "Neuf"
)
Activity.create(
  name: "Rénovation"
)
Activity.create(
  name: "Auto Construction"
)
puts "#{Activity.count} activities have been created"

puts "Database ready"