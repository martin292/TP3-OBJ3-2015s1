package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Salida
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import org.eclipse.xtext.generator.IFileSystemAccess

import static extension ar.edu.unq.obj3.dsl.model.FormatosDeSalidaExtensions.*

class SalidaExtensions {
	static def generarArchivos(Salida it, IFileSystemAccess fsa, Verduleria verduleria){
		salidas.forEach [ generarArchivo(fsa, verduleria)]
	}
}