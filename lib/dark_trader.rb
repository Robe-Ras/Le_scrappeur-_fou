require 'rubygems'
require 'nokogiri'  
require 'open-uri'
require 'restclient'
  


def scrape_method_name
  # Chargement de la page web
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  print_slowly("Processus de téléchargement de la page web enclenché...\n")

  # Utilisation de XPath pour extraire les NOMS (dans cet exemple le nom de chaque cryptomonnaie)
  cryptos_names = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  print_slowly("Extraction des noms des cryptomonnaies terminé....\n")


  # Utilisation de XPath pour extraire les PRIX (dans cet exemple le cours de chaque cryptomonnaie)
  cryptos_prices = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a/span')
  print_slowly("Extraction des cours des cryptomonnaies terminé....\n")

  # Création de deux ARRAY vides pour stocker les noms et les prix
  names_array = []
  prices_array = []

  # Parcourir chaque ligne (cryptomonnaie) et ajouter les NOMS et les PRIX aux ARRAY
  cryptos_names.each do |crypto|
    names_array << crypto.text
  end

  cryptos_prices.each do |crypto|
    prices_array << crypto.text
  end

  print_slowly("Stockage des prix et des cours des cryptomonnaies terminé...\n")

  # Fusionner les deux ARRAY dans un HASH avec des sous tableaux
  # .zip pour combiner les éléments correspondants des deux array
  # to_h pour convertir le tableau final en un hash
  fusion_hash = names_array.zip(prices_array).to_h

  print_slowly("Array fusionnés dans le hash avec succès...\n") 

  # Retourner le résultat du hash
  return fusion_hash
end

  # [BONUS Hacker Style] Fonction pour imprimer lettre par lettre dans le terminal avec pause entre chaque lettre
def print_slowly(text)
  text.each_char do |char|
    print char
    sleep(0.03) # ajuste la durée de la pause entre chaque lettre
    $stdout.flush # assure que le texte est immédiatement affiché
  end
end

# Appeler la méthode et afficher le résultat 
result = scrape_method_name
print_slowly("\nDark Trader, voici le cours de toutes les cryptomonnaies du marché demandé :\n")
puts result
