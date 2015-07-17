package ar.edu.unq.obj3.dsl.generator

import org.eclipse.xtext.generator.IFileSystemAccess
import ar.edu.unq.obj3.dsl.textualVerduler.Verduleria
import static extension ar.edu.unq.obj3.dsl.model.VerduleriaExtensions.*
import static extension ar.edu.unq.obj3.dsl.model.ClientesExtensions.*
import ar.edu.unq.obj3.dsl.textualVerduler.Cliente

class HTMLgenerator {

	static def void generarHTML(IFileSystemAccess fsa, Verduleria verduleria) {
		fsa.generateFile('Info.html', generarPagina(verduleria))
	}

	static def generarPagina(Verduleria verduleria) {
		'''
<!DOCTYPE HTML>
<html>

<head>

	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	
	«agregarStyle»
	
	«agregarScript»

	<title>Verduleria</title>
</head>

<body>

	<br><br>
	
	<div class="container">
		<div class="jumbotron">
			<div class="info">
			
				<h3 class="titulo">Informacion basica</h3>
					<ul class="nav nav-tabs">
  						<li role="presentation" data-toggle="tooltip" title="Total vendido y recaudado" class="btn-totales active" ><a href="#">Totales</a></li>
  						<li role="presentation" data-toggle="tooltip" title="Deudores, con credito y al dia" class="btn-clientes" ><a href="#">Clientes</a></li>
  						<li role="presentation" data-toggle="tooltip" title="Ventas por cliente" class="btn-ventas" ><a href="#">Ventas</a></li>
  						<li role="presentation" data-toggle="tooltip" title="Totales por producto" class="btn-productos" ><a href="#">Productos</a></li>
  						
  						<!-- El dropdown no funciona en el navegador de eclipse -->
  						<li role="presentation" data-toggle="tooltip" title="Declaraciones" class="dropdown navbar-right">
  						<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> 
  						<span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span></a>
  						<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
      						<li class="drop-cli"><a href="#">Ver clientes declarados</a></li>
      						<li class="drop-pro"><a href="#">Ver productos declarados</a></li>
      						<li class="divider"></li>
      						<li class="drop-dec-cli"><a href="#">Declarar cliente</a></li>
      						<li class="drop-dec-pro"><a href="#">Declarar producto</a></li>
    					</ul>
    					</li>
  						
					</ul>
					
					

				<br><br>
				
				<div class="res">
				
					<div class="Totales">   «verduleria.generarTotales»</div> <br>
					<div class="Clientes">  «verduleria.generarDetallesClientes» </div> <br>
					<div class="Ventas">    «verduleria.generarVentasPorClientes» </div> <br>
					<div class="Productos"> «verduleria.generarDetallesDeProductos» </div> <br>
				
					<div class="dec-cli">«verduleria.clientesDeclarados»</div>
					<div class="dec-pro">«verduleria.productosDeclarados»</div>
				
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>
'''
	}

	static def agregarStyle() {
		'''
			<style type="text/css">
				.jumbotron{background-color: #FFFFFF;}
				body{background-color: #F6F6F6;}
				.titulo{position: relative; bottom:25px;}
				.info{text-align: center;}
			</style>
		'''
	}

	static def agregarScript() {
		'''
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script>
	window.onload = function () {
		//alert("Informacion basica de la verduleria");
   		$(".Clientes").hide();
   		$(".Ventas").hide();
   		$(".Productos").hide();
   		$(".dec-cli").hide();
   		$(".dec-pro").hide();
	}
		
	$(document).ready(function(){

		$(".btn-totales").click(function(evento){
			$(".Totales").prependTo(".res");
			$("li").removeClass("active");
			$(this).addClass("active");
			$(".Totales").show("slow");
   			$(".Ventas").hide();
   			$(".Clientes").hide();
   			$(".Productos").hide();
   			$(".dec-cli").hide();
   			$(".dec-pro").hide();
		});

		$(".btn-clientes").click(function(evento){
			$(".Clientes").prependTo(".res");
			$("li").removeClass("active");
			$(this).addClass("active");
			$(".Clientes").show("slow");
   			$(".Totales").hide();
   			$(".Ventas").hide();
   			$(".Productos").hide();
   			$(".dec-cli").hide();
   			$(".dec-pro").hide();
		});

   		$(".btn-ventas").click(function(evento){
   			$(".Ventas").prependTo(".res");
   			$("li").removeClass("active");
			$(this).addClass("active");
   			$(".Ventas").show("slow");
   			$(".Totales").hide();
   			$(".Clientes").hide();
   			$(".Productos").hide();
   			$(".dec-cli").hide();
   			$(".dec-pro").hide();
		});

		$(".btn-productos").click(function(evento){
			$(".Productos").prependTo(".res");
			$("li").removeClass("active");
			$(this).addClass("active");
			$(".Productos").show("slow");
   			$(".Totales").hide();
   			$(".Clientes").hide();
   			$(".Ventas").hide();
   			$(".dec-cli").hide();
   			$(".dec-pro").hide();
		});
		
		$('.dropdown-toggle').click(function() {
    		$('.dropdown-menu').toggle();    		
  		});
  		
  		$(".drop-pro").click(function(evento){
	   		$('.dropdown-menu').toggle();
	  		$(".dec-pro").prependTo(".res");
	  		$("li").removeClass("active");
	  		$(".Totales").hide();
	   		$(".Clientes").hide();
	   		$(".Ventas").hide();
	   		$(".Productos").hide();
	   		$(".dec-cli").hide();
	  		$(".dec-pro").show("slow");
	  	});

	  	$(".drop-cli").click(function(evento){
	  		$('.dropdown-menu').toggle();
	  		$(".dec-cli").prependTo(".res");
	  		$("li").removeClass("active");
	  		$(".Totales").hide();
	   		$(".Clientes").hide();
	   		$(".Ventas").hide();
	   		$(".Productos").hide();
	   		$(".dec-pro").hide();
	  		$(".dec-cli").show("slow");
	  	});
	  	
	  	$(".drop-dec-pro").click(function(evento){
	   		$('.dropdown-menu').toggle();
	   		alert("En construccion!");	  			
	  	});

	  	$(".drop-dec-cli").click(function(evento){
	   		$('.dropdown-menu').toggle();
	   		alert("En construccion!");	  			
	  	});

		$('[data-toggle="tooltip"]').tooltip();

	});
</script>
'''
	}

	static def generarTotales(Verduleria verduleria) {
		'''«verduleria.generarTotalVendido» «verduleria.generarTotalRecaudado»'''
	}

	static def generarTotalVendido(Verduleria verduleria) {
		'''Se vendio por un total de «verduleria.calcularTotalVendido» pesos.<br>'''
	}

	static def generarTotalRecaudado(Verduleria verduleria) {
		'''Se recaudaron en total «verduleria.calcularTotalRecaudado» pesos.<br>'''
	}

	static def generarDetallesClientes(Verduleria verduleria) {
		'''
<b class="col-sm-6 text-right">Deben:</b>  <div class="col-sm-6 text-left">«verduleria.clientesDeudores.imprimir».<br></div>
<b class="col-sm-6 text-right">Tienen credito:</b>  <div class="col-sm-6 text-left">«verduleria.clientesConCredito.imprimir».<br></div>
<b class="col-sm-6 text-right">Al dia:</b>  <div class="col-sm-6 text-left">«verduleria.clientesAlDia.imprimir».<br></div>
'''
	}

	static def imprimir(Iterable<Cliente> lista) {
		lista.join(", <br>", [imprimir])
	}

	static def generarVentasPorClientes(Verduleria verduleria) {
		'''
<b class="col-sm-6 text-right">Ventas por cliente:</b>
<div class="col-sm-6 text-left"> «generarGastosDeClientes(verduleria)» </div>
<b class="col-sm-6 text-right">No hicieron compras:</b>
<div class="col-sm-6 text-left"> «generarClientesSinCompras(verduleria)» </div>
'''
	// generarGastosDeClientes(verduleria) + generarClientesSinCompras(verduleria)
	}

	static def generarGastosDeClientes(Verduleria verduleria) {
		verduleria.clientesQueRealizaronCompras.join("<br>", [ c |
			c.name + " gasto " + verduleria.gastosQueGeneroElCliente(c) + " en " +
				verduleria.cantidadDeComprasQueRealizoCliente(c) +
				(if(verduleria.cantidadDeComprasQueRealizoCliente(c) == 1) " compra." else " compras.")
		])
	}

	static def generarClientesSinCompras(Verduleria verduleria) {
		verduleria.clientesQueNoRealizaronCompras.join(", <br>", [ c |
			if (c == verduleria.clientesQueNoRealizaronCompras.last) {
				c.name + "."
			} else {
				c.name
			}
		])
	}

	static def generarDetallesDeProductos(Verduleria verduleria) {
		'''<b class="col-sm-6 text-right">Se vendieron:</b> 
		<div class="col-sm-6 text-left">«verduleria.detallesDeProductosVendidos»</div>
		«verduleria.detallesProductosQueNoSeVendieron»'''
	}

	static def detallesDeProductosVendidos(Verduleria verduleria) {
		verduleria.productosVendidos.map [ p |
			'''«p.name», total vendido «verduleria.cantidadDeKilosVendidoDe(p)» kilos.<br>'''
		]
	}

	static def detallesProductosQueNoSeVendieron(Verduleria verduleria) {
		var productosNoVendidos = verduleria.productosQueNoSeVendieron
		switch productosNoVendidos {
			case productosNoVendidos.length ==
				0
			: ""
			default: '''<b class="col-sm-6 text-right">No se vendieron:</b> <div class="col-sm-6 text-left">«productosNoVendidos.join(", <br>", [name])».</div>'''
		}
	}

	static def clientesDeclarados(Verduleria verd) {
		verd.clientes.join(", <br>", [name])
	}

	static def productosDeclarados(Verduleria verd) {
		verd.productos.join(", <br>", [name])
	}

}