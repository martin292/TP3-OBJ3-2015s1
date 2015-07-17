package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Cliente

import static extension ar.edu.unq.obj3.dsl.model.DeclaracionExtensions.*

class ClientesExtensions {
	static def deudaInicial(Cliente it){
		declaracion.deuda
	}
	
	static def creditoInicial(Cliente it){
		declaracion.credito
	}
	
	static def imprimir(Cliente c){
		c.name + " " + c.declaracion.imprimir
	}
	
	static def saldo(Cliente it){
		creditoInicial - deudaInicial
	}
}