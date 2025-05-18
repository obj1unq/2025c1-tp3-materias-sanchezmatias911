import requisitos.*
import estudianteClass.*
import listaEspera.*
/*

    Requisitos de materia: 
    * la Materia tiene un estado con una clase Correlativa,Credito, Año o Nada que heredan de una superclase Requisito
    * la materia tiene un metodo cumpleRequisitos(materia,estudiante) que manda un mensaje al estado y delega la responsabilidad
    *la materia tiene creditosQue otorga y un metodo que devuelve esos creditos
    *el Estudiante tiene un metodo creditosTotales() que son los creditos que viene acumulando de materiasAprobadas aprobadas
    *las materias tienen una constante año(de que año de la carrera s la materia) y saben decir el año


*/
class Carrera{

  const materiasCarrera 

    method materiasCarrera() = materiasCarrera
}
class Materia{
    
    const requisito // ESTADO: Alguna Clase de Requisito

    const nombreMateria //STRING

    const alumnosInscriptos = []

    const listaDeEspera = []

    const manejoListaEspera // ESTADO: Alguna Clase de manejo de lista de espera

    const anho

    const cupoMaximo //INT

    //Creditos
    const creditosQueOtorga //int

    method anho() = anho
   
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
            //listaDeEspera.add(alumno)
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
       // self.inscribirAlumnoEnEspera()
       manejoListaEspera.añadirAlumno()
       manejoListaEspera.actualizarListaEspera()
    }

    /*method inscribirAlumnoEnEspera(){
        const alumnoEnEspera = listaDeEspera.first()

        alumnosInscriptos.add(alumnoEnEspera)

        listaDeEspera.remove(alumnoEnEspera)

    }*/
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


