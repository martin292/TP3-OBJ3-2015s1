package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Cliente
import ar.edu.unq.obj3.dsl.textualVerduler.Producto
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria

import static extension ar.edu.unq.obj3.dsl.model.ClientesExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.CompraExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.UnidadExtensions.*
import static extension ar.edu.unq.obj3.dsl.utils.UtilsIterable.*

class VerduleriaExtensions {
	/**
	 *Calcula y retorna el total vendido, inluyendo el total de las compras que quedaron debiendo.
	 * @return Double
	 */
	static def calcularTotalVendido(Verduleria it){
		compras.map [vendido].sum
	}
	
	/**
	 * Retorna el total recaudado, sumando solo las compras que fueron pagadas.
	 * @return Double
	 */
	static def calcularTotalRecaudado(Verduleria it){
		compras.map [recaudado].sum
	}
	
	/**
	 * Retorna todos los clientes deudores.
	 */
	static def clientesDeudores(Verduleria it){
		clientes.filter[ c | poseeDeuda(c) ]
	}
	
	/**
	 * Retorna todos los clientes que poseen credito.
	 */
	static def clientesConCredito(Verduleria it){
		clientes.filter[ c | poseeCredito(c)]
	}
	
	/**
	 * Retorna todos los clientes que se encuentran al dia.
	 */
	static def clientesAlDia(Verduleria it){
		clientes.filter[ c | estaAlDia(c) ]
	}
	
	/**
	 * Retorna la lista de clientes que realizaron almenos una compra.
	 */
	static def clientesQueRealizaronCompras(Verduleria it){
		compras.map [comprador].unique
	}
	
	/**
	 * Retorna la lista de clientes que no realizaron ninguna compra.
	 */
	 //Arreglar este y el otro igual
	static def clientesQueNoRealizaronCompras(Verduleria it){
		clientes.delete(clientesQueRealizaronCompras)
	}
	
	/**
	 * Retorna las compras que realizo un cliente dado.
	 */
	static def comprasQueRealizoElCliente(Verduleria it, Cliente cliente){
		compras.filter [realizoLaCompraEsteCliente(cliente)]
	}
	
	/**
	 * Retorna la cantidad de compras que realizo un cliente dado.
	 */
	static def cantidadDeComprasQueRealizoCliente(Verduleria it, Cliente cliente){
		comprasQueRealizoElCliente(cliente).size
	}
	
	/**
	 * Retorna el gasto que genero en total un cliente dado.
	 */
	static def gastosQueGeneroElCliente(Verduleria it, Cliente cliente){
		comprasQueRealizoElCliente(cliente).map [calcularTotal].sum
	}
	
	/**
	 * Retorna un ArrayList sin repetidos que contiene todos los productos vendidos.
	 * @return ArrayList<Producto>
	 */
	static def productosVendidos(Verduleria it){
		compras.map [productosVendidos].flatten.unique
	}
	
	/**
	 * Retorna un ArrayList con todos los productos que no fueron vendidos.
	 */
	static def productosQueNoSeVendieron(Verduleria it){
		productos.delete(productosVendidos)
	}
	
	/**
	 * Calcula y retorna los kilos vendidos del producto dado.
	 * @return Double
	 */
	static def cantidadDeKilosVendidoDe(Verduleria it, Producto p){
		val productosComprados= compras.map [productosComprados].flatten
		productosComprados.filter [producto == p].map [unidad.pesoEnKilos].sum
	}
	
	/**
	 * Retorna la lista de compras que debe el cliente dado.
	 */
	static def comprasQueDebeElCliente(Verduleria it, Cliente cliente){
		comprasQueRealizoElCliente(cliente).filter [!estaPaga]
	}
	
	/**
	 * Retorna true si el cliente esta al dia.
	 */
	static def estaAlDia(Verduleria it, Cliente cliente){
		(deudaDelCliente(cliente) - creditoDelCliente(cliente)) == 0
	}
	
	/**
	 * Retorna true si el cliente posee credito.
	 */
	static def poseeCredito(Verduleria it, Cliente cliente){
		(deudaDelCliente(cliente) - creditoDelCliente(cliente)) < 0
	}
	
	/**
	 * Retorna true si el cliente posee deuda.
	 */
	static def poseeDeuda(Verduleria it, Cliente cliente){
		(deudaDelCliente(cliente) - creditoDelCliente(cliente)) > 0
	}
	
	/**
	 * Retorna la deuda del cliente dado.
	 */
	static def deudaDelCliente(Verduleria it, Cliente cliente){
		deudaParcial(cliente) - cliente.creditoInicial
	}
	
	/**
	 * Retorna el credito que posee el cliente dado.
	 */
	static def creditoDelCliente(Verduleria it, Cliente cliente){
		cliente.creditoInicial - deudaParcial(cliente)
	}
	
	/**
	 * Retorna la deuda parcial, siendo la suma de todas las compras que debe mas su deuda inicial
	 * pero sin restarle el credito que puede tener.
	 */
	private static def deudaParcial(Verduleria it, Cliente cliente){
		comprasQueDebeElCliente(cliente).map [vendido].sum + cliente.deudaInicial
	}
	
	static def contieneFormatoDeSalida(Verduleria it){
		formatoDeSalida != null
	}
}