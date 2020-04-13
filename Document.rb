class Document
    attr_accessor :isbn,:titre,:fichier,:auteur,:disponibilite

    def initialize(isbn,titre,fichier,auteur)
        @isbn=isbn
        @titre=titre
        @fichier=fichier
        @auteur=auteur
        @disponibilite = "Disponible"
    end

    def to_s
        "ISBN : " + self.isbn + ", Titre : " + self.titre + ", Fichier : " + self.fichier + ", Auteur : " + self.auteur.nom + " " + self.auteur.prenom + ", Disponibilite : " + self.disponibilite
    end
end

class Livre < Document
    def initialize(isbn,titre,fichier,auteur)
        super(isbn,titre,fichier,auteur)
    end

end