package ar.edu.unq.obj3.dsl.generator

import ar.edu.unq.obj3.dsl.textualVerduler.Cliente
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import org.eclipse.xtext.generator.IFileSystemAccess

import static extension ar.edu.unq.obj3.dsl.model.ClientesExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.VerduleriaExtensions.*

class TxtGenerator {
	def void generarTxt(IFileSystemAccess fsa, Verduleria verduleria){
		fsa.generateFile(
			'Informacion Basica.txt',
			'''
			«generarDetallesDeLosTotales(verduleria)»
			
			«generarDetallesClientes(verduleria)»
			
			«generarVentasPorClientes(verduleria)»
			
			«generarDetallesDeProductos(verduleria)»
			''' 
		)
	}
	
	def generarDetallesDeLosTotales(Verduleria verduleria){
		'''Totales
		«generarTotalVendido(verduleria)»
		«generarTotalRecaudado(verduleria)»
		'''
	}
	
	def generarTotalVendido(Verduleria verduleria){
		'''Se vendio por un total de «verduleria.calcularTotalVendido» pesos.'''
	}
	
	def generarTotalRecaudado(Verduleria verduleria){
		'''Se recaudaron en total «verduleria.calcularTotalRecaudado» pesos.'''
	}
	
	def generarDetallesClientes(Verduleria verduleria){		
		'''
		Clientes
				«generarDetalleDeDeudores(verduleria)»
				«generarDetalleClientesConCredito(verduleria)»
				«generarDetalleClientesAlDia(verduleria)»
		'''
	}
		
	def generarDetalleDeDeudores(Verduleria verduleria){
		'''
		Deben:
			«FOR cliente: verduleria.clientesDeudores»
			«cliente.name» «verduleria.deudaDelCliente(cliente)» pesos
			«ENDFOR»
		'''
	}
	
	def generarDetalleClientesConCredito(Verduleria verduleria){
		'''
		Tienen credito:
			«FOR cliente: verduleria.clientesConCredito»
			«cliente.name» «verduleria.creditoDelCliente(cliente)» pesos
			«ENDFOR»
		'''
	}
	
	def generarDetalleClientesAlDia(Verduleria verduleria){
		'''
		Al dia:
			«FOR cliente: verduleria.clientesAlDia»
			«cliente.name»
			«ENDFOR»
		'''
	}
	
	def imprimir(Iterable<Cliente> lista){
		lista.join(", ", [imprimir])		
	}
			
	def generarVentasPorClientes(Verduleria verduleria){
		generarGastosDeClientes(verduleria) + '\t' + '\t' +
			generarClientesSinCompras(verduleria)
	}
	
	def generarGastosDeClientes(Verduleria verduleria){
	'''Ventas por cliente:
		«FOR cliente: verduleria.clientesQueRealizaronCompras»«
		cliente.name» gasto «verduleria.gastosQueGeneroElCliente(cliente)» en «
		verduleria.cantidadDeComprasQueRealizoCliente(cliente)» «
		if(verduleria.cantidadDeComprasQueRealizoCliente(cliente) == 1)"compra" else "compras"».
		«ENDFOR»'''
	}

	/**
	 * Retorna un CharSequence que detalla los clientes que no realizaron compras.
	 */	
	def generarClientesSinCompras(Verduleria verduleria){
		'''No hicieron compras : «verduleria.clientesQueNoRealizaronCompras.join(", ", [name])».'''
	}
	
	/**
	 * Retorna un CharSequence que detalla los productos vendidos y los no vendidos.
	 */
	def generarDetallesDeProductos(Verduleria verduleria){
		'''Productos
		«detallesDeProductosVendidos(verduleria)»
		«detallesProductosQueNoSeVendieron(verduleria)»
		'''
	}
	
	def detallesDeProductosVendidos(Verduleria verduleria){
		verduleria.productosVendidos.map [ p | 
			'''«p.name», total vendido «verduleria.cantidadDeKilosVendidoDe(p)» kilos.'''].join('\n\t\t')
	}
	
	/**
	 *Retorna un CharSequence con los productos que no se vendieron. 
	 */
	def detallesProductosQueNoSeVendieron(Verduleria verduleria){
		'''No se vendieron:  «verduleria.productosQueNoSeVendieron .join(", ", [name])»'''
	}
	
}