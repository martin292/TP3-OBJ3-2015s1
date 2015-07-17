package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Compra
import ar.edu.unq.obj3.dsl.textualVerduler.CompraConDetalle
import ar.edu.unq.obj3.dsl.textualVerduler.CompraSinDetalle
import static extension ar.edu.unq.obj3.dsl.model.ProductoCompradoExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.DetalleCompraExtensions.*
import ar.edu.unq.obj3.dsl.textualVerduler.Cliente
import static extension ar.edu.unq.obj3.dsl.utils.UtilsIterable.*

class CompraExtensions {
	/**
	 * Retorna el total vendido dependiendo el detalle de la compra.
	 */
	static def dispatch vendido(CompraConDetalle compra){
		compra.detalleCompra.vendido(compra)
	}
	
	/**
	 * Retorna el total vendido, calculado de acuerdo al precio de los productos comprados.
	 */
	static def dispatch vendido(CompraSinDetalle compra){
		compra.calcularTotal
	}
	
	/**
	 * Retorna el total recaudado dependiendo el detalle de la compra.
	 */
	static def dispatch recaudado(CompraConDetalle compra){
		compra.detalleCompra.recaudado 
	}
	
	/**
	 * Retorna el total recaudado, calculado de acuerdo al precio de los productos comprados.
	 */
	static def dispatch recaudado(CompraSinDetalle compra){
		compra.calcularTotal
	}
	
	/**
	 * Calcula y retorna el valor de la compra de acuerdo a los precios de los productos comprados.
	 */
	static def calcularTotal(Compra compra){
		compra.productosComprados.map [calcularPrecio].sum 
	}
	
	/**
	 * Retorna true si la compra corresponde al cliente dado.
	 */
	static def realizoLaCompraEsteCliente(Compra compra, Cliente cliente){
		compra.comprador == cliente
	}
	
	/**
	 * Retorna una lista con los productos vendidos que corresponde a la compra.
	 */
	static def productosVendidos(Compra compra){
		compra.productosComprados.map [producto]
	}
	
	static def dispatch estaPaga(CompraConDetalle compra){
		compra.detalleCompra.estaPaga
	}
	
	static def dispatch estaPaga(CompraSinDetalle compra){
		true
	}
}