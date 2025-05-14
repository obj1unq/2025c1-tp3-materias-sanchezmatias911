class Carrera{

  const materiasCarrera = #{}

    method materiasCarrera() = materiasCarrera
}
class Materia{

    const nombreMateria = self.toString()

    const requisitos=#{}

    method nombreMateria() = nombreMateria

    method requisitos() = requisitos
}
class Registro{
    const  estudiante 
    const materia
    const nota

    method estudiante() = estudiante
    method materia() = materia
    method nota() = nota    
}
class Estudiante{

    const nombre = self.toString()

    method nombre() = nombre 

    var  cantMateriasAprobadas = 0

    var promedio = 0

    
    method tieneAprobada(materia){

    }

    method sePuedeInscribirEn(materia){}

    method inscribir(){}
}
