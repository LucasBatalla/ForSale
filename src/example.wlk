class Inmueble{
	var property operacion
	var property metrosCuadrados
	var property cantAmbientes
	var property tipoInmueble
	var property estaReservada
	var property duenio
	var zona
	
	method valorInmueble(){
		return tipoInmueble.valor(self) + zona.valorDeZona() 
	}
	
	method reservada(){
		estaReservada = true
	}
	
	
}

class Cliente{
	
	var property inmuebleQueReservo
	
	method pedirReserva(empleado, inmueble){
		empleado.reservar(inmueble)
		inmuebleQueReservo = inmueble
	}
	
	method concretarOperacion(empleado, inmueble){
		empleado.concretar(inmueble,self)
	}
}


class Inmobiliaria{
	var empleados
	var criterioMejorEmpleado
	
	method mejorEmpleado(){
		return criterioMejorEmpleado.mejor(empleados)
	}
	
	
	
	
	
}



class Empleado{
	var property comisiones
	var property operacionesCerradas
	var property cantReservas
	var ventas
	
	method cobrarComision(inmueble){
		comisiones += (inmueble.operacion()).comision(inmueble)
	}
	
	method comisionPorOperacion(inmueble){
		if(ventas.contains(inmueble)){
			return (inmueble.operacion()).comision(inmueble)
		} else
		return 0
	}
	
	method reservar(inmueble){
		inmueble.reservada()
		cantReservas += 1
	}
	
	method concretar(inmueble, cliente){
		if(self.reservo(cliente, inmueble)){
			self.cobrarComision(inmueble)
			operacionesCerradas += 1
			ventas.add(inmueble)
		} else 
		throw new DomainException(message = "El cliente no puede concretar sino reservo")
	}
	
	method reservo(cliente, inmueble){
		return cliente.inmuebleQueReservo() == inmueble
	}
	
	
	
}

object venta{
	const porcentajeSobreValor = 0.015
	
	method comision(inmueble){
		if((inmueble.tipoInmueble()).esLocal()){
			throw new DomainException (message = "Los locales no se pueden vender" )
		}
		return inmueble.valorInmueble() * porcentajeSobreValor
	}
	
	
}

class Alquiler{
	var cantMesesContrato
	
	method comision(inmueble){
		return (inmueble.valorInmueble() * cantMesesContrato) / 50000
	}
}

class Casa{
	var property valorPropiedad
	
	method valor(){
		return valorPropiedad
	}
	
}


class Local inherits Casa{
	var tipoLocal
	
	override method valor(){
		return tipoLocal.precio(self)
	}
	
	method remodelarA(nuevoTipoLocal){
		tipoLocal = nuevoTipoLocal
	}
	
	method esLocal(){
		return true
	}
	
}


object galpon{
	
	method precio(local){
		return local.valorPropiedad() * 0.5
	}
	
}

class ALaCalle{
	
	var montoFijo
	
	method precio(local){
		return montoFijo
	}
	
}





object ph{
	var valorMetroCuadrado = 14000
	var valorMinimoTotal = 500000
	
	method valor(inmueble){
		return (self.valorPorMetroCuadrado(inmueble)).max(valorMinimoTotal)
	}
	
	method valorPorMetroCuadrado(inmueble){
		return inmueble.metrosCuadrados() * valorMetroCuadrado
	}
	
}

object dptos{
	var valorPorAmbiente = 350000
	
	method valor(inmueble){
		return inmueble.cantAmbientes() * valorPorAmbiente
	}
	
}

class Zona{
	var valorDeZona
	
	method valor(){
		return valorDeZona
	}
}

object masComisiones{
	
	method mejor(empleados){
		return empleados.max({empleado => empleado.comisiones()})
	}
	
}

object masOperaciones{
	
	method mejor(empleados){
		return empleados.max({empleado => empleado.operacionesCerradas()})
	}
	
}
object masReservas{
	
	method mejor(empleados){
		return empleados.max({empleado => empleado.cantReservas()})
	}
}


