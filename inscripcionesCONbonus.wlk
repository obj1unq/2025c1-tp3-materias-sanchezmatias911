
/*

    Requisitos de materia: 
    * la Materia tiene un estado con una clase Correlativa,Credito, Año o Nada que heredan de una superclase Requisito
    * la materia tiene un metodo cumpleRequisitos(materia,estudiante) que manda un mensaje al estado y delega la responsabilidad
    *la materia tiene creditosQue otorga y un metodo que devuelve esos creditos
    *el Estudiante tiene un metodo creditosTotales() que son los creditos que viene acumulando de materiasAprobadas aprobadas


*/
class Carrera{

  const materiasCarrera 

    method materiasCarrera() = materiasCarrera
}
class Materia{
    
    const requisito //

    const nombreMateria //STRING

    const alumnosInscriptos = []

    const listaDeEspera = []

    

    const cupoMaximo //INT

    //Creditos
    const creditosQueOtorga //int
   
    method creditosQueOtorga() = creditosQueOtorga
    


    method nombreMateria() = nombreMateria

    //REQUISITOS
    method cumpleRequisitos(estudiante){
        return requisito.cumpleRequisito(estudiante)
    }

    

    
    //####### INSCRIBIR ALUMNO
    method inscribirAlumno(alumno){

        self.validarInscripcion(alumno)
        self.inscribir(alumno)
        
    }

    method inscribir(alumno){
        if (not self.hayCupo()){
            self.añadirAListaDeEspera(alumno)
        }
        else {
            self.añadirACursada(alumno)
        }
    }

    method añadirAListaDeEspera(alumno){
        if(not self.estaEnListaDeEspera(alumno)){ //evita repetidos en lista de espera
            listaDeEspera.add(alumno)
        }
    }

    method estaEnListaDeEspera(alumno) = listaDeEspera.contains(alumno)

    method añadirACursada(alumno){
        alumnosInscriptos.add(alumno)
    }

    method validarInscripcion(alumno){
        if(not self.sePuedeInscribir(alumno)){
            self.error("El alumno no se puede inscribir a esta materia")
        }
    }

    method sePuedeInscribir(estudiante) = estudiante.sePuedeInscribir(self)


    method hayCupo() = self.cantidadInscriptos() < self.cupoMaximo()

    method cantidadInscriptos() = alumnosInscriptos.size()

    method cupoMaximo() = cupoMaximo

    

    //######### DAR DE BAJA ##############

    method darDeBaja(estudiante){
        self.quitarEstudianteInscripto(estudiante)
        self.inscribirAlumnoEnEspera()
    }

    method inscribirAlumnoEnEspera(){
        const alumnoEnEspera = listaDeEspera.first()

        alumnosInscriptos.add(alumnoEnEspera)

        listaDeEspera.remove(alumnoEnEspera)

    }
    // ############## RESULTADOS INSCRIPCION ###########
    method alumnosInscriptos() = alumnosInscriptos

    method alumnosEnEspera() = listaDeEspera
   
    //####################### REGISTRO DE MATERIAS APROBADAS  ###############
    
    method aprobarEstudiante(estudiante,nota){
        self.validarRegistro(estudiante,self)
        const registro = new Registro(est = estudiante, mat= self, notaFinal = nota)
        self.actualizarAlumnoYMateria(estudiante,registro) // el estudiante ya no esta inscripto porque aprobo

    }

    method actualizarAlumnoYMateria(estudiante,registro){
        self.actualizarAlumnoAprobado(estudiante,registro)
        self.quitarEstudianteInscripto(estudiante)
    }

    method validarRegistro(estudiante,materia){
        if(estudiante.tieneAprobada(self)){
            self.error("El Estudiante ya tiene  la materia aprobada")
        }
    }

    method actualizarAlumnoAprobado(estudiante,reg){
        
        estudiante.registroMateriasAprobadas().add(reg)
       
    }

    method quitarEstudianteInscripto(estudiante){
        alumnosInscriptos.remove(estudiante)
    }

        
}
class Registro {
    
    const est
    const mat
    const notaFinal

    method registro() = #{est,mat,notaFinal}

    method materia() = mat 

    method nota() = notaFinal
 }


class Estudiante{

    const registroMateriasAprobadas= #{} //registros 
    const carrerasInscripto = #{}

    //######### Punto 2 #########
    method cantidadMateriasAprobadas(){}

    method promedio(){
        self.promedioNotas(self.notas())
    } 

    method notas() = self.listaMateriasAprobadas().map({e => e.nota()})

    method listaMateriasAprobadas() {
        // Convierto el set de materiasAprobadas aprobadas a una lista para no perder informacion 
        // de las notas, que podrian estar repetidas
        return registroMateriasAprobadas.asList() 
    }

    method promedioNotas(listaNotas){
       return  listaNotas.sum() / listaNotas.size()
    }
   
   
    method tieneAprobada(materia) =  self.materiasAprobadas().contains(materia)
    
    method materiasAprobadas() =  registroMateriasAprobadas.map({r => r.materia()})

    // PUNTO 4
    method materiasDeTodasLasCarreras() =self.materiasDeCarreras().flatten()
    
    method materiasDeCarreras() =carrerasInscripto.map({c => c.materiasCarrera()})
    
    //########### REGISTRAR MATERIA APROBADA ############
    method registroMateriasAprobadas() = registroMateriasAprobadas

    //################ INSCRIPCION ###############
    method sePuedeInscribir(materia){
        return self.materiaEnCarrera(materia) and 
             not self.tieneAprobada(materia) and
             not self.estaInscripto(materia) and
             self.cumploRequisitosDeMateria(materia)

    }

    method materiaEnCarrera(materia){
        return self.materiasDeTodasLasCarreras().contains(materia)
    }

    method estaInscripto(materia){
        return materia.alumnosInscriptos().contains(self)
    }

    // REFACTORIZAR
    method cumploRequisitosDeMateria(materia) =  materia.cumpleRequisios(self)

    

    //###### RESULTADOS INSCRIPCION ####
    
    method resultadosInscripcion(materia){
        if(materia.estaEnListaDeEspera(self)){
            return self.mensajeListaEspera(materia)
        }

        if(self.estaInscripto(materia)){
        
            return self.mensajeInscripto(materia)
        }

        return "Usted nunca realizo inscripcion"
        
    }

    method mensajeInscripto(materia) = "Usted esta inscripto a la materia" + materia.nombreMateria()

    method mensajeListaEspera(materia) = "Usted esta en la lista de espera de la materia: "+ materia.nombreMateria()

    //######### MATERIAS EN LAS QUE ESTOY INSCRIPTO O EN LISTA DE ESPERA ##############

    method materiasInscripto() {
    
        return self.materiasDeTodasLasCarreras().filter({m => self.estaInscripto(m)})
    }

    method materiasEnListaDeEspera() {

        return self.materiasDeTodasLasCarreras().filter({m => m.estaEnListaDeEspera(self)})
    }

    // ############ MATERIAS A LAS QUE ME PUEDO INSCRIBIR """"""
    
    method materiasEnQuePuedeInscribirse(carrera){
        self.validarCarrera(carrera)
        return carrera.materiasCarrera().filter({m => self.sePuedeInscribir(m) })
    }

   
    method validarCarrera(carrera){
        if (not self.estoyCursando(carrera)){
            self.error("No estoy cursando esta carrera")
        }
    }

    method estoyCursando(carrera){
        return carrerasInscripto.contains(carrera)
    }

    //############ INSCRIPCION A CARRERAS ########### 
    method inscribirACarrera(carrera){
        carrerasInscripto.add(carrera)
    }
    //######### REQUISITOS
    method creditosTotales(){
        return self.materiasAprobadas().sum({materia => materia.creditosQueOtorga()})

    }

    
}


class Requisitos {
    method cumpleRequisito(estudiante)
}

class Correlativa inherits Requisitos{
    const correlativas //un set de materias correlativas

    override method cumpleRequisito(estudiante){
        return estudiante.materiasAprobadas().all({materia =>self.aproboCorrelativa(materia)})
    }
    method aproboCorrelativa(materia){
        return correlativas.contains(materia)
    }

    
}
class Credito inherits Requisitos{
    const creditosRequeridos

    override method cumpleRequisito(estudiante){
        return estudiante.creditosTotales() >= creditosRequeridos
    }

   


}
class Año inherits Requisitos{

    /* dada la materiaActual ,necesito buscar en carreras inscripto de estudiante, el set*/
    const materiaActual 
    const añoMateria

    override method cumpleRequisito(estudiante){
        
        return self.aproboTodasDeAñosAnterioresA()
    }

    method materiasDeLaCarrera(estudiante,materiaActual){
        const carrerasEstudiante = estudiante.carrerasInscripto()
        return carrerasEstudiante.find({c =>c.materiasCarrera().contains(materiaActual)}).materiasCarrera()
    }

    
}
class Nada inherits Requisitos{
    override method cumpleRequisito(estudiante) = true
}




