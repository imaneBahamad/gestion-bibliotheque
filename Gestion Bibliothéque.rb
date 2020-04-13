require_relative('Personne.rb')
require_relative('Materiel.rb')
require_relative('Document.rb')
require_relative('Exceptions.rb')
require 'fileutils'
require 'csv'

module Bibliotheque
    $adherents = []
    $materiaux = []
    $documents = []
    $auteurs = []
    $dossier_livres = "D:/ENSAK/S8/Ruby/Mini projet-BAHAMAD-Imane/Livres/"
    $path_CSV = "D:/ENSAK/S8/Ruby/Mini projet-BAHAMAD-Imane/CSV/";

    def ajouterAdherent(adherent)
        $adherents << adherent
    end

    def ajouterOrdinateur(ordinateur)
        $materiaux << ordinateur
    end

    def ajouterLivre(livre,chemin_fichier)
        $documents << livre
        $auteurs << livre.auteur

        raise FichierIntrouvableException.new if !File.exist?(chemin_fichier)
        fichier = File.new(chemin_fichier)
        FileUtils.cp(fichier, $dossier_livres)
        fichier.close
    end

    def ajouterAuteur(auteur)
        $auteurs << auteur
    end

    def afficherAdherent(id)
        $adherents.each do |adherent|
            if adherent.id == id
                puts adherent.to_s
                return
            end
        end 
        raise ElementInconnuException.new("Adhérent")
    end

    def afficherLivre(isbn)
        $documents.each do |livre|
            if livre.isbn == isbn
                puts livre.to_s
                return
            end
        end 
        raise ElementInconnuException.new("Livre")
    end

    def afficherOrdinateur(id)
        $materiaux.each do |ordinateur|
            if ordinateur.id == id
                puts ordinateur.to_s
                return
            end
        end 
        raise ElementInconnuException.new("Ordinateur")
    end

    def afficherAuteur(id)
        $auteurs.each do |auteur|
            if auteur.id == id
                puts auteur.to_s
                return
            end
        end 
        raise ElementInconnuException.new("Auteur")
    end

    def listerIDAuteurs
        $auteurs.each do |auteur|
            puts auteur.id
        end
    end

    def listerIDMateriaux
        $materiaux.each do |materiel|
            puts materiel.id
        end
    end

    def listerMateriaux
        $materiaux.each do |materiel|
            puts materiel.to_s
        end
    end

    def listerAdherents
        $adherents.each do |adherent|
            puts adherent.to_s
        end
    end

    def listerDocuments
        $documents.each do |document|
            puts document.to_s
        end
    end

    def supprimerAdherent(id)
        $adherents.each do |adherent|
            if adherent.id == id
                $adherents.delete(adherent)
                puts "---- Adhérent supprimé avec succès ----"
                return
            end
        end
        raise ElementInconnuException.new("Adhérent")
    end

    def supprimerDocument(isbn)
        $documents.each do |document|
            if document.isbn == isbn
                $documents.delete(document)
                raise FichierIntrouvableException.new if !File.exist?($dossier_livres+document.fichier)
                File.delete($dossier_livres+document.fichier)
                puts "---- Document supprimé avec succès ----"
                return
            end
        end
        raise ElementInconnuException.new("Document")
    end

    def supprimerMateriel(id)
        $materiaux.each do |materiel|
            if materiel.id == id
                $materiaux.delete(materiel)
                puts "---- Matériel supprimé avec succès ----"
                return
            end
        end
        raise ElementInconnuException.new("Materiel")
    end

    def emprunterOrdinateur(id)
        $materiaux.each do |ordinateur|
            if ordinateur.id == id
                if ordinateur.disponibilite == "Disponible"
                    ordinateur.disponibilite = "Non disponible"
                else
                    raise DejaEmprunteException.new("Ordinateur")
                end
                return
            end
        end
        raise ElementInconnuException.new("Ordinateur")
    end

    def rendreOrdinateur(id)
        $materiaux.each do |ordinateur|
            if ordinateur.id == id
                if ordinateur.disponibilite == "Non disponible"
                    ordinateur.disponibilite = "Disponible"
                else
                    puts "!!!!! Cet ordinateur est déjà disponible !!!!!"
                end
                return
            end
        end
        raise ElementInconnuException.new("Ordinateur")
    end

    def emprunterLivre(isbn)
        $documents.each do |document|
            if document.isbn == isbn
                if document.disponibilite == "Disponible"
                    document.disponibilite = "Non disponible"
                else
                    raise DejaEmprunteException.new("Livre")
                end
                return
            end
        end
        raise ElementInconnuException.new("Livre")
    end

    def rendreLivre(isbn)
        $documents.each do |document|
            if document.isbn == isbn
                if document.disponibilite == "Non disponible"
                    document.disponibilite = "Disponible"
                else
                    puts "!!!!! Ce livre est déjà disponible !!!!!"
                end
                return
            end
        end
        raise ElementInconnuException.new("Livre")
    end

    def nombreOccurences(chaine,fichier)
        raise FichierIntrouvableException.new if !File.exist?($dossier_livres+fichier)
        f = File.open($dossier_livres+fichier)
        compteur = 0
        File.readlines(f).each do |ligne|
            mots = ligne.split
            mots.each do |mot|
                if mot == chaine
                    compteur = compteur + 1
                end
            end
        end
        f.close
        return compteur
    end

    def dixMotsPlusUtilises(fichier)
        raise FichierIntrouvableException.new if !File.exist?($dossier_livres+fichier)
        f = File.open($dossier_livres+fichier)
        hash = Hash.new()
        File.readlines(f).each do |ligne|
            mots = ligne.split
            mots.each do |mot|
                hash[mot] = nombreOccurences(mot,fichier)
            end
        end  
        
        val =  hash.sort_by {|k, v| -v}
        i=0
        puts "Les dix mots les plus utilisés dans le livre \"" + fichier + "\" sont :"        
        val.each do |value|
            print value
            i = i + 1
            if i == 10
                puts ""
                return
            end
        end
        f.close
    end

    def sauvegardeCSV()   
            CSV.open($path_CSV+"adherents.csv", "w") do |csv|
            $adherents.each do |adherent|
                csv << [adherent.id, adherent.nom, adherent.prenom, adherent.age, adherent.statut]
            end
        end

        CSV.open($path_CSV+"documents.csv", "w") do |csv|
            $documents.each do |document|
                csv << [document.isbn, document.titre, document.fichier, document.auteur,document.disponibilite]
            end
        end

        CSV.open($path_CSV+"matériaux.csv", "w") do |csv|
            $materiaux.each do |materiel|
                if materiel.class == "Ordinateur"
                    csv << [materiel.id, materiel.nom, materiel.marque, materiel.disponibilite, materiel.os]
                else
                    csv << [materiel.id, materiel.nom, materiel.marque, materiel.disponibilite]
                end
            end
        end

        CSV.open($path_CSV+"auteurs.csv", "w") do |csv|
            $auteurs.each do |auteur|
                csv << [auteur.id, auteur.nom, auteur.prenom, auteur.age]
            end
        end
    end

    def chargerCSV()
        raise FichierIntrouvableException.new("CSV") if !File.exist?($path_CSV+"adherents.csv") || 
        !File.exist?($path_CSV+"documents.csv") || !File.exist?($path_CSV+"matériaux.csv") ||
        !File.exist?($path_CSV+"auteurs.csv")

        CSV.foreach($path_CSV+"adherents.csv") do |row|
            adherent = Adherent.new(row[0].to_i,row[1],row[2],row[3].to_i,row[4])
            $adherents << adherent
        end

        CSV.foreach($path_CSV+"documents.csv") do |row|
            document = Document.new(row[0],row[1],row[2],Auteur.new(row[3][0],row[3][1],row[3][2],row[3][3]))
            $documents << document
        end

        CSV.foreach($path_CSV+"matériaux.csv") do |row|
            if row.size == 5
                materiel = Ordinateur.new(row[0].to_i,row[1],row[2],row[3])
            else 
                materiel = Materiel.new(row[0].to_i,row[1],row[2])
            end
            $materiaux << materiel
        end

        CSV.foreach($path_CSV+"auteurs.csv") do |row|
            auteur = Auteur.new(row[0].to_i,row[1],row[2],row[3])
            $auteurs << auteur
        end
    end
end


