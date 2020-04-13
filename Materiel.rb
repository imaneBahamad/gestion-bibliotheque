class Materiel
    attr_accessor :id,:nom,:marque,:disponibilite

    def initialize(id,nom,marque)
        @id=id
        @nom=nom
        @marque=marque
        @disponibilite = "Disponible"
    end

    def to_s
        "Identifiant : " + self.id.to_s + ", Nom : " + self.nom + ", Marque : " + self.marque + ", Disponibilite : " + self.disponibilite
    end
end

class Ordinateur < Materiel
    attr_accessor :os

    def initialize(id,nom,marque,os)
        super(id,nom,marque)
        @os=os
    end

    def to_s
        super + ", Système d'exploitation : " + self.os
    end
end
