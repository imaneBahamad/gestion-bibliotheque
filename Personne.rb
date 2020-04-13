class Personne
    attr_accessor :id,:nom,:prenom,:age
    def initialize(id,nom,prenom,age)
        @id=id
        @nom=nom
        @prenom=prenom
        @age=age
    end

    def to_s
        "Identifiant : " + self.id.to_s + ", Nom : " + self.nom + ", Prénom : " + self.prenom + ", Age : " + self.age.to_s
    end
end

class Adherent < Personne
    attr_accessor :statut

    def initialize(id,nom,prenom,age,statut)
        super(id,nom,prenom,age)
        @statut=statut
    end

    def to_s
        super + ", Statut : " + self.statut
    end
end

class Auteur < Personne
    def initialize(id,nom,prenom,age)
        super(id,nom,prenom,age)
    end
end



