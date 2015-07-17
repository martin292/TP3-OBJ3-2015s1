package ar.edu.unq.obj3.dsl.generator

import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import org.eclipse.xtext.generator.IFileSystemAccess

import static extension ar.edu.unq.obj3.dsl.model.VerduleriaExtensions.*

class XMLGenerator {
	
	static def void generarXML(IFileSystemAccess fsa, Verduleria it){
		fsa.generateFile('Informacion Basica.xml', generarPagina())
	}
	
	static def generarPagina(Verduleria it) {
		generarInformacionBasicaEnXml
	}
	
	static def generarTotales(Verduleria it){
	'''
	<Totales>
		<Vendido>«calcularTotalVendido»</Vendido>
		<Recaudado>«calcularTotalRecaudado»</Recaudado>
	</Totales>
	'''	
	}
	
	static def clientesQueTienenDeudas(Verduleria it){
		'''
		<Deben>
			«FOR cliente: clientesDeudores»
			<Cliente nombre="«cliente.name»">
				<Deuda>«deudaDelCliente(cliente)»</Deuda>
			</Cliente>
			«ENDFOR»
		</Deben>
		'''
	}
	
	static def clientesQueTienenCredito(Verduleria it){
		'''
		<TienenCredito>
			«FOR cliente: clientesConCredito»
			<Cliente nombre="«cliente.name»">
				<Credito>«creditoDelCliente(cliente)»</Credito>
			</Cliente>
			«ENDFOR»
		</TienenCredito>
		'''
	}
	
	static def clientesQueEstanAlDia(Verduleria it){
		'''
		<AlDia>
			«FOR cliente: clientesAlDia»
			<Cliente nombre="«cliente.name»">
			</Cliente>
			«ENDFOR»
		</AlDia>
		'''
	}
	
	static def ventas(Verduleria it){
		'''
		«FOR cliente: clientesQueRealizaronCompras»
			<Venta ventaDelCliente="«cliente.name»"
				<GastoGeneradoEnCompras>«gastosQueGeneroElCliente(cliente)»</GastoGeneradoEnCompras>
				<CatidadDeComprasQueRealizo>«cantidadDeComprasQueRealizoCliente(cliente)»</CatidadDeComprasQueRealizo>
			</Venta>
		«ENDFOR»
		'''
	}
	
	static def clientesQueNoTienenCompras(Verduleria it){
		'''
		«FOR cliente: clientesQueNoRealizaronCompras»
			<Cliente nombre="«cliente.name»"></Cliente>
		«ENDFOR»
		'''
	}
	
	static def productosQueFueronVendidos(Verduleria it){
		'''
		«FOR producto: productosVendidos»
			<Producto nombre="«producto.name»">
				<CantidadDeKilosVendidos>«cantidadDeKilosVendidoDe(producto)»</CantidadDeKilosVendidos>
			</Producto>
		«ENDFOR»
		'''
	}
	
	static def productosNoVendidos(Verduleria it){
		'''
		«FOR producto: productosQueNoSeVendieron»
			<Producto nombre="«producto.name»"></Producto>
		«ENDFOR»
		'''
	}
	
	static def generarClientes(Verduleria it){
		'''
		<Clientes>
			«clientesQueTienenDeudas»
			«clientesQueTienenCredito»
			«clientesQueEstanAlDia»
		</Clientes>
		'''
	}
	
	static def generarVentasPorCliente(Verduleria it){
		'''
		<VentasPorCliente>
			<Ventas>
				«ventas»
			</Ventas>
			<NoHicieronCompras>
				«clientesQueNoTienenCompras»
			</NoHicieronCompras>
		</VentasPorCliente>
		'''
	}
	
	static def generarProductos(Verduleria it){
		'''
		<Productos>
				<ProductosVendidos>
					«productosQueFueronVendidos»
				</ProductosVendidos>
				<ProductosNoVendidos>
					«productosNoVendidos»
				</ProductosNoVendidos>
			</Productos>
		'''
	}
	
	static def generarInformacionBasicaEnXml(Verduleria it){
	'''
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<Verduleria>
		«generarTotales»
		«generarClientes»
		«generarVentasPorCliente»
		«generarProductos»
	</Verduleria>
	'''
	
	}
	
}