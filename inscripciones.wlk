class Carrera{

  const materiasCarrera = #{}

    method materiasCarrera() = materiasCarrera
}
class Materia{

    var cantInscriptos = 0
    const alumnosInscriptos = #{}

    method inscribirAlumno(alumno){
        self.validarCupo()
        alumnosInscriptos.add(alumno)
        cantInscriptos = cantInscriptos + 1
    }

    method validarCupo(){
        if(self.hayCupo()){
            self.error("No puedo inscribir alumno")
        }
    }

    method hayCupo() = cantInscriptos<= self.cupoMaximo()

    method cupoMaximo() = 30



    const requisitos=#{}

    
    method requisitos() = requisitos
}
class Registro{
    const estudiante 
    const materia
    const nota

    method estudiante() = estudiante
    method materia() = materia
    method nota() = nota   

    //method registro () = [estudiante,materia,nota] 
}
class Estudiante{

   
    const carreras = #{}
    
    const materiasAprobadas = #{} // registros

    method materiasAprobadas() = materiasAprobadas.size()

    var promedio = 0

    
    method tieneAprobada(materia){

    }

    method sePuedeInscribirEn(materia){}

    method inscribir(materia){}
}

class  Lista{
    const lista =#{} 
    
    method agregar(algo){
        lista.add(algo)
    }

    method lista() = lista

    
    
}