package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.CuartoKilo
import ar.edu.unq.obj3.dsl.textualVerduler.Kilo
import ar.edu.unq.obj3.dsl.textualVerduler.MedioKilo
import ar.edu.unq.obj3.dsl.textualVerduler.NGramos
import ar.edu.unq.obj3.dsl.textualVerduler.NKilos
import ar.edu.unq.obj3.dsl.textualVerduler.UnidadEnKilo

class UnidadExtensions {
	static def dispatch pesoEnKilos(UnidadEnKilo uk){
		uk.peso
	}
	
	static def dispatch pesoEnGramos(UnidadEnKilo uk){
		 uk.peso * 1000 
	}
	
	static def dispatch pesoEnKilos(NGramos nGramos){
		nGramos.peso / 1000
	}
	
	static def dispatch pesoEnGramos(NGramos nGramos){
		nGramos.peso
	}
	
	private static def dispatch peso(NKilos nKilos){
		nKilos.kilos 	
	}
	
	private static def dispatch peso(Kilo kilo){
		1 
	}
	
	private static def dispatch peso(MedioKilo medioKilo){
		0.5
	}
	
	private static def dispatch peso(CuartoKilo cuartoKilo){
		0.250
	}
	
	private static def dispatch peso(NGramos nGramos){
		nGramos.gramos
	}
}