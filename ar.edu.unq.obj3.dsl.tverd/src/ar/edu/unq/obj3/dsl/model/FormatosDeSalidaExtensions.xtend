package ar.edu.unq.obj3.dsl.model

import ar.edu.unq.obj3.dsl.textualVerduler.Html
import ar.edu.unq.obj3.dsl.textualVerduler.Sql
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import ar.edu.unq.obj3.dsl.textualVerduler.Xml
import org.eclipse.xtext.generator.IFileSystemAccess

import static ar.edu.unq.obj3.dsl.generator.HTMLgenerator.*
import static ar.edu.unq.obj3.dsl.generator.SQLGenerator.*
import static ar.edu.unq.obj3.dsl.generator.XMLGenerator.*

class FormatosDeSalidaExtensions {
	static dispatch def generarArchivo(Html it, IFileSystemAccess fsa, Verduleria verduleria){
		generarHTML(fsa, verduleria)
	}
	
	static dispatch def generarArchivo(Xml it, IFileSystemAccess fsa, Verduleria verduleria){
		generarXML(fsa, verduleria)
	}
	
	static dispatch def generarArchivo(Sql it, IFileSystemAccess fsa, Verduleria verduleria){
		generarSQL(fsa, verduleria)
	}
}