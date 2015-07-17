package ar.edu.unq.obj3.dsl.utils

class UtilsIterable {
	/**
	 * Dado un iterable, retorna una ArrayList sin elementos repetidos.
	 * @return ArrayList<T>
	 */
	def static <T> unique(Iterable<T> iterable) {
		val result= newArrayList
		iterable.forEach [p |
			if(!result.contains(p)){
				result.add(p)
			}
		]
		result 
	}
	
	/**
	 * Dado un iterable de Double, retorn la suma de todos los elementos
	 * @return Double
	 */	
	def static sum(Iterable<Double> iterable){
		var res= iterable.reduce [res, n | res + n]
		if(res == null)
			res= 0.0
		res
	}
	
	/**
	 * Retorna una nueva lista resultante de haber removido todos los elementos que contiene la lista dada.
	 */
	def static <T> delete(Iterable<T> origin, Iterable<T> remove){
		val result= newArrayList
		origin.forEach [ e |
			if(!remove.exists [ o | o == e]){
				result.add(e)
			}
		]
		result
	}
}