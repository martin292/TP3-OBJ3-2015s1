/*
 * generated by Xtext
 */
package ar.edu.unq.obj3.dsl.ui.labeling

import ar.edu.unq.obj3.dsl.textualVerduler.Cliente
import ar.edu.unq.obj3.dsl.textualVerduler.Compra
import ar.edu.unq.obj3.dsl.textualVerduler.Producto
import ar.edu.unq.obj3.dsl.textualVerduler.ProductoComprado
import ar.edu.unq.obj3.dsl.textualVerduler.Tarea
import com.google.inject.Inject
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider

/**
 * Provides labels for EObjects.
 * 
 * See https://www.eclipse.org/Xtext/documentation/304_ide_concepts.html#label-provider
 */
class TextualVerdulerLabelProvider extends DefaultEObjectLabelProvider {

	@Inject
	new(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}
	
	def text(Compra compra){
		"Compra de " + compra.comprador.name
	}
	
	def image(Compra compra){
		"compra.jpg"	
	}
	
	def image(Cliente cliente){
		"cliente.jpg"	
	}
	
	def image(Producto producto){
		"producto.jpg"	
	}
	
	def text(Tarea tarea){
		"Tarea"	
	}
	
	def image(Tarea tarea){
		"tarea.jpg"
	}
	
	def text(ProductoComprado pc){
		"Producto Comprado"
	}
}
