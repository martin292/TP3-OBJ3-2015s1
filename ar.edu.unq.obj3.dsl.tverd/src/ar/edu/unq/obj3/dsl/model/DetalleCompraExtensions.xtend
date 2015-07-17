package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Compra
import ar.edu.unq.obj3.dsl.textualVerduler.DebeLaCompra
import ar.edu.unq.obj3.dsl.textualVerduler.Paga
import ar.edu.unq.obj3.dsl.textualVerduler.PagaLaCompra
import ar.edu.unq.obj3.dsl.textualVerduler.QuedaDebiendo
import ar.edu.unq.obj3.dsl.textualVerduler.Redondeo
import ar.edu.unq.obj3.dsl.textualVerduler.RedondeoYPaga
import ar.edu.unq.obj3.dsl.textualVerduler.RedondeoYQuedaDebiendo

import static extension ar.edu.unq.obj3.dsl.model.CompraExtensions.*

class DetalleCompraExtensions {
	static def dispatch vendido(Paga paga, Compra compra){
		paga.pagoTotal as double
	}

	static def dispatch vendido(RedondeoYPaga redondeoYPaga, Compra compra){
		redondeoYPaga.paga.pagoTotal as double
	}
	
	static def dispatch vendido(Redondeo redondeo, Compra compra){
		redondeo.totalRedondeado as double
	}
	
	static def dispatch vendido(RedondeoYQuedaDebiendo redondeoYDebe, Compra compra){
		redondeoYDebe.redondeo.totalRedondeado as double
	}
	
	static def dispatch vendido(QuedaDebiendo debe, Compra compra){
		compra.calcularTotal
	}
	
	static def dispatch recaudado(DebeLaCompra debe){
		0.0
	}
	
	static def dispatch recaudado(Redondeo redondeo){
		redondeo.totalRedondeado	
	}
	
	static def dispatch recaudado(RedondeoYPaga redYPaga){
		redYPaga.paga.pagoTotal
	}
	
	static def dispatch recaudado(Paga paga){
		paga.pagoTotal
	}
	
	static def dispatch estaPaga(PagaLaCompra p){
		true
	}
	
	static def dispatch estaPaga(DebeLaCompra d){
		false
	}
}