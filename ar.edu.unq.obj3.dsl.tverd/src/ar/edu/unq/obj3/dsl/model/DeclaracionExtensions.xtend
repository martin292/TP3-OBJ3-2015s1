package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Declaracion
import ar.edu.unq.obj3.dsl.textualVerduler.Debe
import ar.edu.unq.obj3.dsl.textualVerduler.AlDia
import ar.edu.unq.obj3.dsl.textualVerduler.SeLeDebe

class DeclaracionExtensions {
	
	
	static dispatch def Debe(Declaracion d){
		false
	}
	static dispatch def Debe(Debe d){
		true
	}
	static dispatch def Debe(AlDia d){
		false
	}
	static dispatch def Debe(SeLeDebe d){
		false
	}
	
	
	static dispatch def seLeDebe(Declaracion d){
		false
	}
	static dispatch def seLeDebe(SeLeDebe d){
		true
	}
	static dispatch def seLeDebe(Debe d){
		false
	}
	static dispatch def seLeDebe(AlDia d){
		false
	}
	
	
	static dispatch def alDia(Declaracion d){
		false
	}
	static dispatch def alDia(AlDia d){
		true
	}
	static dispatch def alDia(SeLeDebe d){
		false
	}
	static dispatch def alDia(Debe d){
		false
	}
	
	static def dispatch deuda(Debe it){
		valorDeLaDeuda as double
	}
	
	static def dispatch deuda(AlDia it){
		0.0
	}
	
	static def dispatch deuda(SeLeDebe it){
		0.0
	}
	
	static def dispatch credito(Debe it){
		0.0
	}
	
	static def dispatch credito(AlDia it){
		0.0
	}
	
	static def dispatch credito(SeLeDebe it){
		creditoAFavor as double
	}
	
	static dispatch def imprimir(Declaracion d){
		""
	}
	static dispatch def imprimir(AlDia d){
		""
	}
	static dispatch def imprimir(Debe d){
		d.valorDeLaDeuda + " pesos"
	}
	static dispatch def imprimir(SeLeDebe d){
		d.creditoAFavor + " pesos"
	}
	
}