require 'rubygems'
require 'nokogiri'  
require 'open-uri'
require 'restclient'


def get_townhall_email
  
  # Chargement de la page web de la mairie
  page = Nokogiri::HTML(URI.open("https://annuaire-des-mairies.com/95/avernes.html"))
  

  # Utilisation de XPath pour extraire le NOM de la mairie d'Avernes
  townhall_name = page.xpath('/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a')
  
  # Utilisation de XPath pour extraire l'EMAIL de la mairie d'Avernes
  townhall_mail = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')


  # Création de deux ARRAY vides pour stocker le nom de la mairie et l'email
  townhall_name_array = []
  townhall_mail_array = []

  # Parcourir chaque ligne (cryptomonnaie) et ajouter les NOMS et les PRIX aux ARRAY
  townhall_name.each do |contact_townhall|
    townhall_name_array << contact_townhall.text #.strip
  end

  townhall_mail.each do |contact_townhall|
    townhall_mail_array << contact_townhall.text
  end

  # Fusionner les deux ARRAY dans un HASH avec des sous tableaux
  # .zip pour combiner les éléments correspondants des deux array
  # to_h pour convertir le tableau final en un hash
  fusion_hash = townhall_name_array.zip(townhall_mail_array).to_h

  return fusion_hash

end

# Appeler la méthode et afficher le résultat 
result_avernes = get_townhall_email
puts result_avernes




#------ ETAPE 2 ------

def get_townhall_urls
  # Chargement de la page web de toutes les mairies du Val d'Oise
  page = Nokogiri::HTML(URI.open("https://annuaire-des-mairies.com/val-d-oise.html"))

  # Utilisation de XPath pour extraire la totalité des URLs des mairies du Val d'Oise
  townhall_links = page.xpath('//a[@class="lientxt"]/@href')

  # Création d'un ARRAY vide pour stocker la liste des URLs des mairies du Val d'Oise
  townhall_urls_array = []

  # Ajouter l'URL de chaque lien dans l'array
  townhall_links.each do |link|
    townhall_urls_array << "https://annuaire-des-mairies.com/val-d-oise.html#{link.text}"
  end

  # Retourner l'array complet
  return townhall_urls_array
end

# Appeler la méthode et afficher le résultat 
result_urls = get_townhall_urls

# Afficher la liste des URLs 
result_urls.each do |url|
  puts url
end

### Abandon cause trop d'erreur et manque de temps 

