
/*
    ##################################
    REGISTRO DE UNA MATERIA APROBADA: 
    ##################################
    *el objeto Materia entiende el mensaje  'aprobarEstudiante(estudiante,materia,nota)' 
    que instancia un objeto registro, valida el registro y lo agrega al Estudiante

*/

class Carrera{

  const materiasCarrera = #{}

    method materiasCarrera() = materiasCarrera
}
class Materia{

    const alumnosInscriptos = #{}
    
    method inscribirAlumno(alumno){

        self.validarCupo()
        alumnosInscriptos.add(alumno)
        
    }

    method cantidadInscriptos() = alumnosInscriptos.size()

    method validarCupo(){
        if(self.hayCupo()){
            self.error("No puedo inscribir alumno")
        }
    }

    method hayCupo() = self.cantidadInscriptos() <= self.cupoMaximo()

    method cupoMaximo() = 30
   
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

    method materiasDeTodasLasCarreras() =self.materiasDeCarreras().flatten()
    
    method materiasDeCarreras() =carrerasInscripto.map({c => c.materiasCarrera()})
    
    //########### REGISTRAR MATERIA APROBADA ############
    method agregarMateriaAprobada(reg){

        materiasAprobadas.add(reg.registro())
    }

    //################ INSCRIPCION ###############
    method puedeInscribirse(materia){}
}



