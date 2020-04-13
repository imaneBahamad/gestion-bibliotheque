class ElementInconnuException < StandardError
    def initialize(element="Element")
        super("!!!!! "+ element + " inconnu !!!!!")
    end
end

class DejaEmprunteException < StandardError
    def initialize(element="Element")
        super("!!!!! "+ element + " déjà emprunté !!!!!")
    end
end

class FichierIntrouvableException < StandardError
    def initialize(name="Fichier")
        super("!!!!! " + name + " introuvable !!!!!")
    end
end