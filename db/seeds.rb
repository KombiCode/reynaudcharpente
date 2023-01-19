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
# Rating.destroy_all
# Category.destroy_all
# Opinion.destroy_all

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
  description: "La charpente est le squelette de votre maison. Elle permet de soutenir et de lier vos murs entre eux
  ainsi que de porter votre couverture. C’est la compétence historique de l’entreprise. Des fermes en
  bois massif aux lamellés-collés de la fin du 20ème siècle, nous avons suivi l’évolution
  technologique sans perdre notre savoir-faire. C’est aujourd’hui une de nos grandes forces dans la
  rénovation de charpentes anciennes."
)
Skill.create(
  title: "COUVERTURE",
  description: "La couverture est le revêtement de votre toiture. C’est celle-ci qui permet de conserver votre toit au
  sec et qui recueille votre isolation. De la tuile au bac acier en passant par les tavaillons, nous sommes
  en capacité de couvrir votre toit en fonction de vos goûts et des contraintes des PLU. Nous
  disposons également de l’agrément pour l’étanchéité de toit terrasse – végétalisé ou pas- par
  membrane EPDM collée à froid."
)
Skill.create(
  title: "ZINGUERIE",
  description: "Les eaux de pluie descendent le long du toit, il faut les canaliser et les récupérer à l’aide de
  chéneaux, descentes, abergements, etc … pour qu’elles ne dégradent pas l’ouvrage. La zinguerie
  permet également d’habiller les bandeaux pour des raisons esthétiques et pour augmenter leur
  durabilité."
)
Skill.create(
  title: "MAISON OSSATURE BOIS (M.O.B.)",
  description: "Pionnier en Isère, notre première M.O.B. date de 1982. Elle est toujours en parfait état. Nous avons
  acquis cette technique dans les années 1980 grâce à un voyage en Amérique du Nord complété par
  la formation Maison Bois Outil Concept du C.N.D.B. (Comité National pour le Développement du
  Bois) en 2002. En effet la structure d’une maison ossature bois est bien plus complexe qu’un
  montant de bois tous les 60 cm."
)
Skill.create(
  title: "ISOLATION",
  description: "Avec la recherche de performances pour avoir des maisons à basse consommation (B.B.C.) voire
  nulle, l’isolation et l’étanchéité à l’air sont des enjeux cruciaux pour les bâtiments d’aujourd’hui et
  de demain. Nous privilégions les isolants naturels comme la fibre de bois. En plus de ses capacités
  d’isolation du froid, la fibre de bois offre un confort d’été très appréciable dans la vallée du
  Grésivaudan grâce à son déphasage (vitesse de propagation de la chaleur liée à la nature et la masse
  du matériau)."
)
# Skill.create(
#   title: "EXTENSION & SURÉLÉVATION",
#   description: "C’est l’un des domaines où la rapidité de chantier grâce à la technique ossature bois prend tout son sens. La préfabrication des éléments permet de limiter au minimum la durée des travaux. Le poids de la solution ossature bois -bien plus légère que les solutions maçonnées – est un grand avantage et permet d’agrandir quasiment toutes les maisons par le haut. Vous bénéficiez de volumes habitables en plus, sans avoir réduit votre jardin."
# )
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

activity = Activity.create(
  name: "Avant Projet"
)
ActionText::RichText.create!(record_type: 'Activity', record_id: activity.id, name: 'content', body: "Besoin d’accompagnement dès le début de votre projet ? Nous pouvons vous aider dans la
  réalisation de vos démarches administratives, la dépose de votre permis de construire, la recherche
  des bons contacts pour vous guider ainsi que l’étude de votre avant-projet.
  Notre bureau d’étude est à votre disposition pour réaliser vos plans préliminaires ainsi que vos plans
  d’exécutions.
  Nous bénéficions du DCE qui vous permet d’accéder à des avantages fiscaux. Enfin, notre réseau
  de partenaires est à votre disposition pour rencontrer des professionnels correspondant à vos
  besoins."
)

activity = Activity.create(
  name: "Neuf"
)
ActionText::RichText.create!(record_type: 'Activity', record_id: activity.id, name: 'content', body: "Vous avez besoin d’un charpentier pour la construction de votre maison ? Le bois et notre savoir-faire
  sont la solution à vos besoins.
  Depuis 1958 REYNAUD Charpente construit des toits (charpente, couverture et zinguerie) qui
  abritent leurs habitants de génération en génération. Notre première maison en ossature bois date de
  1982. Nous avons fait partie des pionniers en Isère. Découvrez notre histoire ici (lien à l’historique).
  Notre expérience nous permet de vous offrir des solutions modernes ou traditionnelles, mais
  toujours dans le respect des normes et de la sécurité.
  Nous avons acquis un savoir-faire dans la construction des maisons basses consommations (BBC)
  et à énergie positive, bien au-dessus de la simple RT2012. Notre savoir-faire est également reconnu
  par La Maison Passive.
  
  Du bureau d’étude à la pose sur place, nous disposons de l’expérience et du savoir-faire pour vous
  accompagner dans la construction de votre nouvelle maison. Notre spécialité est la réalisation de
  maison individuelle ou collective et le travail du bois.
  
  Nos types de constructions ainsi que nos corps de métier :
  - MOB / Passive : (lien vers compétence développée MOB)
  - Charpente traditionnelle : (lien vers compétence développée charpente)
  - Couverture (lien vers compétence développée couverture)
  - Zinguerie (lien vers compétence développée zinguerie)
  - Isolation (lien vers compétence développée isolation)
  Afin de vous faire une idée de notre savoir-faire, vous pouvez jeter un oeil à nos réalisations
  précédentes (lien vers les réalisations)."
)

activity = Activity.create(
  name: "Rénovation"
)
ActionText::RichText.create!(record_type: 'Activity', record_id: activity.id, name: 'content', body: "Vous avez besoin d’un charpentier pour la rénovation de votre maison ? Le bois et notre savoir-faire
  sont la solution à vos besoins.
  Depuis 1958 REYNAUD Charpente construit et rénove des toits (charpente, couverture et
  zinguerie) qui abritent leurs habitants de génération en génération.
  Notre expérience nous permet de vous offrir des solutions modernes ou traditionnelles, mais
  toujours dans le respect des normes et de la sécurité.
  Nous avons acquis un savoir-faire dans la construction des maisons basses consommations (BBC)
  et à énergie positive. Cette expérience nous permet de vous proposer des solutions performantes
  pour la réfection de votre isolation.

  Du bureau d’étude à la rénovation sur place, nous disposons de l’expérience et du savoir-faire pour
  vous accompagner dans la rénovation de votre maison. Notre spécialité est la rénovation de maison
  individuelle ou collective et le travail du bois.
  
  Nos services proposés pour la rénovation et la transformation :
  - Réfection de toiture (lien vers compétence développée couverture / zinguerie)
  - Réfection d’isolation (lien vers compétence développée isolation)
  - Réfection de toiture (lien vers compétence développée en charpente)
  - Surélévation et extension (lien vers compétence développée surélévation et extension)
  
  Afin de vous faire une idée de notre savoir-faire, vous pouvez jeter un oeil à nos rénovations et
  extensions précédentes (lien vers les réalisations)."
)

activity = Activity.create(
  name: "Auto Construction"
)
ActionText::RichText.create!(record_type: 'Activity', record_id: activity.id, name: 'content', body: "Envie de vous lancer avec vos propres moyens ?
  Reynaud Charpente dispose d’une expérience et d’un bureau d’étude à votre disposition. Nous
  pouvons vous accompagner dans votre projet d’auto construction de la conception à la livraison en
  passant par la taille de vos charpentes et murs ossatures bois. En plus de ces prestations, Reynaud
  Charpente reste à l’écoute et peut vous fournir les conseils nécessaires à la bonne réalisation de la
  pose de votre future maison.
  Prestations proposées pour l’auto construction :
  - Conception
  - Taille (renvoie vers charpente ou machine de taille)
  - Livraison (renvoie vers les moyens de l’entreprise)
  - Conseils pour la pose"
)

puts "#{Activity.count} activities have been created"

# puts "Add categories"
# cat1 = Category.create(
#   name: "Variété des qualifications"
# )
# cat2 = Category.create(
#   name: "Degré de réactivité"
# )
# cat3 = Category.create(
#   name: "Rapidité et efficacité"
# )
# cat4 = Category.create(
#   name: "Qualité du travail fourni"
# )
# cat5 = Category.create(
#   name: "Rapport qualité / prix"
# )
# cat6 = Category.create(
#   name: "Vous recommande"
# )
# puts "#{Category.count} categories have been created"

puts "Database ready"