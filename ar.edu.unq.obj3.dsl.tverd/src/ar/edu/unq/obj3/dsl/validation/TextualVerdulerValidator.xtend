/*
 * generated by Xtext
 */
package ar.edu.unq.obj3.dsl.validation

import ar.edu.unq.obj3.dsl.textualVerduler.Cliente
import ar.edu.unq.obj3.dsl.textualVerduler.CompraConDetalle
import ar.edu.unq.obj3.dsl.textualVerduler.FormatosDeSalida
import ar.edu.unq.obj3.dsl.textualVerduler.NGramos
import ar.edu.unq.obj3.dsl.textualVerduler.NKilos
import ar.edu.unq.obj3.dsl.textualVerduler.Producto
import ar.edu.unq.obj3.dsl.textualVerduler.ProductoComprado
import ar.edu.unq.obj3.dsl.textualVerduler.Salida
import ar.edu.unq.obj3.dsl.textualVerduler.TextualVerdulerPackage
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import java.util.ArrayList
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.validation.Check

import static extension ar.edu.unq.obj3.dsl.model.CompraExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.ProductoCompradoExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.UnidadExtensions.*

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class TextualVerdulerValidator extends AbstractTextualVerdulerValidator {
	public static val KILOS_INCORRECTO = 'kilosIncorrecto'
	public static val GRAMOS_INCORRECTO = 'gramosIncorrecto'
	private val kilosCorrectos= newArrayList(2.0, 3.0)
	private val gramosCorrectos= newArrayList(50.0, 100.0)
	
	@Check
	def checkNombreClienteNoRepetido(Verduleria verd){
		comprobarAplicando(verd.clientes,"El nombre del cliente no puede estar repetido",
			[Cliente c | c.name.toUpperCase])
	}
	
	@Check
	def checkProductosSinRepetir(Verduleria verd){
		comprobarAplicando(verd.productos,"El nombre del producto no puede estar repetido",
			[Producto p | p.name.toUpperCase])
	}
	
	@Check
	def diferenciaDeCompra(CompraConDetalle comp){	
		if((comp.recaudado - comp.calcularTotal) > 3)
			error("Se pago demasiado", comp, null)
	}
	
	@Check
	def checkPrecioMenorADoscientosPesosElKilo(Producto producto){
		var costoUnKilo= producto.precio / producto.unidad.pesoEnKilos
		if(costoUnKilo > 200)
			error("El precio del producto no puede ser mayor a 200 pesos el kilo", producto, null)
	}
	
	@Check
	def checkPesoCorreco(Producto producto){
		switch producto.unidad {
			NKilos  : validarPeso(kilosCorrectos, producto.unidad.pesoEnKilos, KILOS_INCORRECTO)
			NGramos : validarPeso(gramosCorrectos, producto.unidad.pesoEnGramos, GRAMOS_INCORRECTO)
		}
	}
	
	private def validarPeso(ArrayList<Double> pesosCorrectos, double peso, String tipoError){
		if(! pesosCorrectos.contains(peso))
			error("El precio del producto no puede informarse con el peso dado",
				TextualVerdulerPackage.Literals.PRODUCTO__UNIDAD,
					tipoError)
	}
	
	@Check
	def checkMaximoDeUnMismoProducto(ProductoComprado productoComprado){
		if(productoComprado.gramosDelProductoComprado <= 100){
			validarCantidadDeKilos(productoComprado, 4,
				"Solo se pueden comprar hasta 4 kilos de productos cuyo precio esta publicado en gramos.")
		}
		else{
			validarCantidadDeKilos(productoComprado, 20,
				"Solo se pueden comprar hasta 20 kilos de productos cuyo precio esta publicado en kilos.")
		}
	} 
	
	private def validarCantidadDeKilos(ProductoComprado productoComprado, Integer topeDeKilosPermitidos,
		String unError){
		if(productoComprado.cantidadDekilosAComprar > topeDeKilosPermitidos){
			error(unError, productoComprado, null)
		}
	}
	
	@Check
	def checkFormatoDeSalidaNoRepetido(Salida salida){
		comprobarAplicando(salida.salidas,"El formato de salida no puede estar repetido",
			[FormatosDeSalida f | f.eClass.toString])
	}
	
	private def <T extends EObject> comprobarAplicando(EList<T> list, String dError, (T)=>String f) {
		val nombres= newArrayList()
		list.forEach [T e |
			if(nombres.contains(f.apply(e)))
				error(dError, e, null)
			else
				nombres.add(f.apply(e))
		]
	}
}
