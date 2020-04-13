require_relative('Gestion Bibliothéque.rb')
include Bibliotheque

def menu
    puts "------------------Menu principal------------------"
    puts "0- Quitter"
    puts "1- Lancer le sous-menu"
    puts "2- Lancer d'un cout toute les fonctionnalitées du sous-menu"
    puts ""
    print "--- Votre choix ? -> "
    choix = gets.to_i
    return choix
end

def sousMenu
    puts "------------------Sous-menu------------------"
    puts "------------------Ajout------------------"
    puts "1- Ajouter un adhérent"
    puts "2- Ajouter un livre" #Lorsque un livre est ajouté à la bibliothéque son auteur est ajouté automatiquement 
    puts "3- Ajouter un ordinateur portable"
    puts "4- Ajouter un auteur"
    puts "------------------Affichage------------------"
    puts "5- Afficher les informations d'un adhérent"
    puts "6- Afficher les informations d'un document"
    puts "7- Afficher les informations d'un matériel"
    puts "8- Afficher les informations d'un auteur"
    puts "9- Lister les identifiants des auteurs disponibles"
    puts "10- Lister les identifiants des matériaux disponibles"
    puts "11- Lister les adhérents disponibles"
    puts "12- Lister les documents disponibles"
    puts "13- Lister les matériaux disponibles"
    puts "------------------Suppression------------------"       
    puts "14- Supprimer un adhérent"
    puts "15- Supprimer un document"
    puts "16- Supprimer un matériel"
    puts "------------------Emprunt------------------"       
    puts "17- Emprunter un ordinateur"
    puts "18- Emprunter un livre"
    puts "19- Rendre un ordinateur"
    puts "20- Rendre un livre"
    puts "------------------Opérations------------------"       
    puts "21- Compter le nombre d'occurences d'une chaine de caractères dans un livre"
    puts "22- Afficher les 10 mots les plus utilisés dans un livre"
    puts "------------------Opérations------------------"       
    puts "23- Charger la bibliothèque à partir d'un fichier CSV"
    puts "24- Enregistrer la bibliothèque dans un fichier CSV"
    puts ""
end

def lancerChoix(choix)
    case choix
    when 1
            print "--- Identifant ? -> "
            id = gets.to_i
            print "--- Nom ? -> "
            nom = gets.chomp
            print "--- Prénom ? -> "
            prenom = gets.chomp
            print "--- Age ? -> "
            age = gets.to_i
            print "--- Statut ? -> "
            statut = gets.chomp
            adherent = Adherent.new(id,nom,prenom,age,statut)
            ajouterAdherent(adherent)     
    when 2
        print "--- ISBN ? -> "
        isbn = gets.chomp
        print "--- Titre ? -> "
        titre = gets.chomp
        print "--- Chemin fichier ? (chemin absolu) -> "
        chemin_fichier = gets.chomp
        tab = chemin_fichier.split('\\')
        nom_fichier = tab[tab.size-1]
        print "--- Identifiant de l'auteur ? -> "
        identifiant_auteur = gets.to_i
        print "--- Nom de l'auteur ? -> "
        nom_auteur = gets.chomp
        printf "--- Prénom de l'auteur ? -> "
        prenom_auteur = gets.chomp
        printf "--- Age de l'auteur ? -> "
        age_auteur = gets.to_i
        auteur = Auteur.new(identifiant_auteur,nom_auteur,prenom_auteur,age_auteur)
        livre = Livre.new(isbn,titre,nom_fichier,auteur)
        ajouterLivre(livre,chemin_fichier)
    when 3
        print "--- Identifant ? -> "
        id = gets.to_i
        print "--- Nom ? -> "
        nom = gets.chomp
        print "--- Marque ? -> "
        marque = gets.chomp
        print "--- Système d'exploitation ? -> "
        os = gets.chomp
        ordinateur = Ordinateur.new(id,nom,marque,os)
        ajouterOrdinateur(ordinateur)
    when 4
        print "--- Identifant ? -> "
        id = gets.to_i
        print "--- Nom ? -> "
        nom = gets.chomp
        print "--- Prénom ? -> "
        prenom = gets.chomp
        print "--- Age ? -> "
        age = gets.to_i
        auteur = Auteur.new(id,nom,prenom,age)
        ajouterAuteur(auteur)
    when 5
        print "--- Identifiant ? -> "
        id = gets.to_i
        afficherAdherent(id)
    when 6
        print "--- ISBN ? -> "
        isbn = gets.chomp
        afficherLivre(isbn)
    when 7
        print "--- Identifiant ? -> "
        id = gets.to_i
        afficherOrdinateur(id)
    when 8
        print "--- Identifiant ? -> "
        id = gets.to_i
        afficherAuteur(id)
    when 9
        listerIDAuteurs
    when 10
        listerIDMateriaux
    when 11
        listerAdherents
    when 12
        listerDocuments
    when 13
        listerMateriaux
    when 14
        print "--- Identifiant ? -> "
        id = gets.to_i
        supprimerAdherent(id)
    when 15
        print "--- ISBN ? -> "
        isbn = gets.chomp
        supprimerDocument(isbn)
    when 16
        print "--- Identifiant ? -> "
        id = gets.to_i
        supprimerMateriel(id)
    when 17
        print "--- Identifiant ? -> "
        id = gets.to_i
        emprunterOrdinateur(id)
    when 18
        print "--- ISBN ? -> "
        isbn = gets.chomp
        emprunterLivre(isbn)
    when 19
        print "--- Identifiant ? -> "
        id = gets.to_i
        rendreOrdinateur(id)
    when 20
        print "--- ISBN ? -> "
        isbn = gets.chomp
        rendreLivre(isbn)
    when 21
        print "--- Fichier ? -> "
        fichier = gets.chomp
        print "--- Chaine de caractères ? "
        chaine = gets.chomp
        puts "Le nombre d'occurences de " + chaine + " dans le livre \"" + fichier + "\" est : " + nombreOccurences(chaine,fichier).to_s
    when 22
        print "--- Fichier ? -> "
        fichier = gets.chomp
        dixMotsPlusUtilises(fichier)
    when 23
        chargerCSV()
    when 24
        sauvegardeCSV()
    else
        puts "!!!!! Choix invalide !!!!!"
    end
end

def lancerTous()
    sousMenu
    for i in 1 .. 24
        puts "Voulez-vous executer l'action " + i.to_s + " du sous-menu ? (O/N) (n'importe quel autre caractère pour Quitter)"
        reponse = gets.chomp
        if reponse.downcase == "O".downcase
            lancerChoix(i)
        elsif reponse.downcase == "N".downcase
            next
        else
            return
        end    
    end
end


notDone = true

while notDone
    case menu
    when 0 
        notDone = false
    when 1
        sousMenu
        print "--- Votre choix ? -> "
        choix = gets.to_i
        begin
            lancerChoix(choix)
        rescue => exception
            puts exception
        end
              
    when 2
        lancerTous()
    else
        puts "!!!!! Choix invalide !!!!!"
    end
end
