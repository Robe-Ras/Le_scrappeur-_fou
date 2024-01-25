require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Méthode pour récupérer le nom de la mairie à partir de l'URL
def get_townhall_name(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  townhall_name = page.xpath('//h1[contains(text(), "Nom de la mairie")]/following-sibling::p').text.strip
  return townhall_name
end

# Méthode pour récupérer l'email de la mairie à partir de l'URL
def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  townhall_email = page.xpath('//td[contains(text(), "E-mail")]/following-sibling::td').text.strip
  return townhall_email
end

# Méthode pour récupérer les URLs de toutes les mairies du Val d'Oise
def get_townhall_urls
  page = Nokogiri::HTML(URI.open("https://annuaire-des-mairies.com/val-d-oise.html"))
  all_links = page.css('a.lientxt')
  townhall_urls_array = all_links.map { |link| "https://annuaire-des-mairies.com#{link['href']}" }
  return townhall_urls_array
end

# Appeler la méthode pour obtenir les URLs de toutes les mairies du Val d'Oise
result_urls = get_townhall_urls

# Créer deux nouveaux arrays pour stocker les noms et les emails
townhall_names_array = []
townhall_emails_array = []

# Pour chaque URL de mairie, récupérer le nom et l'email
result_urls.each do |url|
  name = get_townhall_name(url)
  email = get_townhall_email(url)

  townhall_names_array << name
  townhall_emails_array << email
end

# Afficher les listes des noms et des emails dans le terminal
puts "Liste des noms des mairies :"
puts townhall_names_array

puts "\nListe des emails des mairies :"
puts townhall_emails_array