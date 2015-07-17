package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.ProductoComprado
import static extension ar.edu.unq.obj3.dsl.model.UnidadExtensions.*

class ProductoCompradoExtensions {
	
	static def calcularPrecio(ProductoComprado productoComprado){
		var producto= productoComprado.producto
		var unidad= productoComprado.unidad
		var peso= unidad.pesoEnKilos()
		(peso * producto.precio) / producto.unidad.pesoEnKilos
	}
	
	static def gramosDelProductoComprado(ProductoComprado productoComprado){
		productoComprado.producto.unidad.pesoEnGramos
	}
	
	
	static def cantidadDekilosAComprar(ProductoComprado productoComprado){
		productoComprado.unidad.pesoEnKilos
	}
	
}