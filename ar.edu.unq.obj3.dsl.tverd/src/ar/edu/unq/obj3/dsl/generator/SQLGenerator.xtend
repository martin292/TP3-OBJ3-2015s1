package ar.edu.unq.obj3.dsl.generator


import ar.edu.unq.obj3.dsl.textualVerduler.Cliente
import ar.edu.unq.obj3.dsl.textualVerduler.Compra
import ar.edu.unq.obj3.dsl.textualVerduler.Producto
import ar.edu.unq.obj3.dsl.textualVerduler.ProductoComprado
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import org.eclipse.emf.common.util.EList
import org.eclipse.xtext.generator.IFileSystemAccess

import static extension ar.edu.unq.obj3.dsl.model.UnidadExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.ClientesExtensions.*

class SQLGenerator {
	static val TABLA_CLIENTE = 'cliente'
	static val TABLA_PRODUCTO = 'producto'
	static val TABLA_COMPRA = 'compra'
	static val TABLA_PRODUCTO_COMPRADO = 'producto_comprado'
	
	static def generarSQL(IFileSystemAccess fsa, Verduleria verduleria){
		fsa.generateFile('database.sql', 
			'''
			«generarInsertsDeClientes(verduleria)»
			
			«generarInsertsDeProductos(verduleria)»
			
			«generarInsertsDeCompras(verduleria)»''')
	}
	
	static def generarInsertsDeClientes(Verduleria it){
//		val clientes = verduleria.clientes
		'''
		INSERT INTO «TABLA_CLIENTE»
		VALUES
		«clientes.join(',\n', [valuesCliente])»;
		'''
	}
	
	static def generarInsertsDeProductos(Verduleria verduleria){
		val productos = verduleria.productos
		'''
		INSERT INTO «TABLA_PRODUCTO»
		VALUES
		«productos.join(',\n', [ p | valuesProducto(p)])»;
		'''
	}
	
	static def generarInsertsDeCompras(Verduleria verduleria){
		val compras = verduleria.compras
		'''
		«FOR compra: compras»
		INSERT INTO «TABLA_COMPRA»
		VALUES
		«valuesCompra(compra)»;
		
		«insertsDeProductosComprados(compra.productosComprados)»
		
		«ENDFOR»
		'''
	}
	
	static def insertsDeProductosComprados(EList<ProductoComprado> productosComprados){
		'''
		INSERT INTO «TABLA_PRODUCTO_COMPRADO»
		VALUES
		«productosComprados.join(',\n', [ pc | valuesProductoComprado(pc)])»;
		'''
	}
	
	static def valuesProductoComprado(ProductoComprado pc){
		'''(LAST_INSERT_ID(), '«pc.producto.name»', «pc.unidad.pesoEnKilos»)'''
	}
	
	static def valuesProducto(Producto producto){
		'''('«producto.name»', «producto.precio», «producto.unidad.pesoEnKilos»)'''
	}
	
	static def valuesCliente(Cliente cliente){
		'''('«cliente.name»', «cliente.saldo»)'''
	}
	
	static def valuesCompra(Compra compra){
		'''(NULL, '«compra.comprador.name»')'''
	}
}