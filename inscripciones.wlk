
/*  
    NOTAS DE TP3 MATERIAS:
   
    REGISTRO DE UNA MATERIA APROBADA: 
   
    *el objeto Materia entiende el mensaje  'aprobarEstudiante(estudiante,materia,nota)' 
    que instancia un objeto registro, valida el registro y lo agrega al Estudiante

    INSCRIPCION DE ESTUDIANTE :
        *la responsabilidad es de la Materia

    RESULTADOS DE INSCRIPCION : lo que entendi es que la Materia sabe decir que Estudiantes 
    tiene inscriptos y que Estudiantes estan en espera. Y el Estudiante puede preguntarle 
    a la Materia en que lista quedo, si la inscripcion no lanzo una excepcion. Si el alumno nunca se inscribio
    y pregunta los resultados dira que nunca intento inscribirse

*/

class Carrera{

  const materiasCarrera = #{}

    method materiasCarrera() = materiasCarrera
}
class Materia{

    const nombreMateria

    const alumnosInscriptos = #{}

    const listaDeEspera = []

    const requisitos = #{}

    const cupoMaximo = 30


    method requisitos()= requisitos
    
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

    method sePuedeInscribir(alumno) = alumno.sePuedeInscribir()


    method hayCupo() = self.cantidadInscriptos() <= self.cupoMaximo()

    method cantidadInscriptos() = alumnosInscriptos.size()

    method cupoMaximo() = cupoMaximo

    //######### DAR DE BAJA ##############

    method darDeBaja(estudiante){
        alumnosInscriptos.remove(estudiante)
        self.inscribirAlumnoEnEspera()
    }

    method inscribirAlumnoEnEspera(){
        const alumnoEnEspera = listaDeEspera.first()

        alumnosInscriptos.add(alumnoEnEspera)

        alumnoEnEspera.remove(alumnoEnEspera)

    }
    // ############## RESULTADOS INSCRIPCION ###########
    method alumnosInscriptos() = alumnosInscriptos

    method alumnosEnEspera() = listaDeEspera
   
    //####################### REGISTRO DE MATERIAS APROBADAS  ###############
    
    method aprobarEstudiante(estudiante,materia,nota){
        self.validarRegistro(estudiante,materia)
        estudiante.agregarMateriaAprobada(new Registro(est = estudiante, mat= materia, notaFinal = nota))

    }

    method validarRegistro(estudiante,materia){
        if(estudiante.tieneAprobada(materia)){
            self.error("El alumno ya tiene  la materia aprobada")
        }
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

    

    const materiasAprobadas= #{} //registros 
    const carrerasInscripto = #{}

    //######### Punto 2 #########
    method cantidadMateriasAprobadas(){}

    method promedio(){
        self.promedioNotas(self.notas())
    } 

    method notas() = self.listaMateriasAprobadas().map({e => e.nota()})

    method listaMateriasAprobadas() {
        // Convierto el set de materias aprobadas a una lista para no perder informacion 
        // de las notas, que podrian estar repetidas
        return materiasAprobadas.asList() 
    }

    method promedioNotas(listaNotas){
       return  listaNotas.sum() / listaNotas.size()
    }
   
   
    method tieneAprobada(materia) =  self.materias().contains(materia)
    
    method materias() =  materiasAprobadas.map({r => r.materia()})

    // PUNTO 4
    method materiasDeTodasLasCarreras() =self.materiasDeCarreras().flatten()
    
    method materiasDeCarreras() =carrerasInscripto.map({c => c.materiasCarrera()})
    
    //########### REGISTRAR MATERIA APROBADA ############
    method agregarMateriaAprobada(reg){

        materiasAprobadas.add(reg.registro())
    }

    //################ INSCRIPCION ###############
    method puedeInscribirse(materia){
        return self.materiaEnCarrera(materia) and 
             not self.tieneAprobada(materia) and
             not self.estaInscripto(materia) and
             self.cumpleRequisitos(materia)

    }

    method materiaEnCarrera(materia){
        return self.materiasDeTodasLasCarreras().contains(materia)
    }

    method estaInscripto(materia){
        return materia.alumnosInscriptos().contains(self)
    }

    method cumpleRequisitos(materia){
        return materia.requisitos().forEach({m => self.tieneAprobada(m)})
    }

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

    method materiasInscripto() {}

    method materiasEnListaDeEspera() {}

   self.materiasDeTodasLasCarreras()
}



