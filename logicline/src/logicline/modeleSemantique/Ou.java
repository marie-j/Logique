package logicline.modeleSemantique;

import java.util.Set;

public class Ou extends Formule {
	
	Formule formuleGauche;
	Formule formuleDroite;

	public Ou(Formule gauche,Formule droite) {
		super();
		this.formuleGauche = gauche;
		this.formuleDroite = droite;
	}
	
	@Override
	public String toString() {
		return "(" + this.formuleGauche.toString() + ") ∨ (" + this.formuleDroite.toString() + ")";
	}

	@Override
	public Set<String> variablesLibres() {
		Set<String> libresGauche = formuleGauche.variablesLibres();
		Set<String> libresDroite = formuleDroite.variablesLibres();
		this.libres.addAll(libresGauche);
		this.libres.addAll(libresDroite);
		return this.libres;
	}

	@Override
	public Formule substitue(Substitution s) {
		return new Ou(this.formuleGauche.substitue(s),this.formuleDroite.substitue(s));
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		if (this.variablesLibres().isEmpty()) {
			return this.formuleGauche.valeur() || this.formuleDroite.valeur();
		}
		else {
			throw new VariableLibreException("");
		}
	}
	
	protected boolean contientEt() {
		return this.formuleGauche.contientEt() || this.formuleDroite.contientEt(); 
	}
	
	@Override
	protected Formule negation() {
		return new Et(this.formuleGauche.negation(),this.formuleDroite.negation());
	}
	
	protected Formule entrerNegations() { 
		return new Ou(this.formuleGauche.entrerNegations(),this.formuleDroite.entrerNegations());
	}
	
	@Override 
	protected Formule entrerDisjonctions() {
		
			
			if (this.formuleGauche.contientEt()) {
				
				return new Et(this.formuleGauche.entrerDisjonctions(), this.formuleDroite.entrerDisjonctions());
				
			}
			
			else if (this.formuleDroite.contientEt()) {
				
				return new Et(this.formuleGauche,this.formuleDroite.entrerDisjonctions());
			}
			
			else {
				return this.formuleGauche.ougauche(this.formuleDroite);
			}
			
		}
		
	
	@Override
	public ListeClauses clauses() throws NotFNCException, TrueClauseException, FalseClauseException, VariableClauseException {
		
		ListeClauses clauses = new ListeClauses();
		Clause c = new Clause();
		c.addAll(this.formuleGauche.clause());
		c.addAll(this.formuleDroite.clause());
		clauses.add(c);
		return clauses;
	}
	
	public Clause clause() throws TrueClauseException, FalseClauseException, NotFNCException {
		Clause c = new Clause();
		
		c.addAll(this.formuleGauche.clause());
		c.addAll(this.formuleDroite.clause());
		
		return c;
	}
}
