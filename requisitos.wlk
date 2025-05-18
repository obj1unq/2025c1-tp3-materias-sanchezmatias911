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
class Anho inherits Requisitos{

    
    const materiaActual 
    const anhoMateriaActual

    override method cumpleRequisito(estudiante){
        
        const materiasCarrera =  self.materiasDeLaCarreraActual(estudiante,materiaActual)
        const materiasDeAñosAnteriores = self.materiasDeAñosAnteriores(materiasCarrera, anhoMateriaActual)

        return self.aproboTodasDeAñosAnterioresA(estudiante,materiasDeAñosAnteriores)
       
    }

    //####### MATERIAS DE LA CARRERA ACTUAL #####

    method materiasDeLaCarreraActual(estudiante,materia){
        /* PROPOSITO:
            Dada una materia, la funcion invoca a la carrera a la que pertenece la materia, y de la carrera
            devuelve las materias.
            
            Nota: Esto busca las materias especificas de esa carrera para no mesclarlas con
                  materias de otras carreras
        */
       
        return self.carreraDeMateriaActual(estudiante,materia).materiasCarrera()
    }

    method carreraDeMateriaActual(estudiante,mat){
        /*
            PROPOSITO: 
            Dado un estudiante, se invoca las carreras en las que esta inscripto.
            Dentro del bloque en find, se busca la carrera que contenga en su coleccion de materias, a la materia
            que se pasa por parametro
        */
        return self.carrerasEstudiante(estudiante).find({c =>self.laMateriaEstaEnCarrera(c,mat)})
    }

    method carrerasEstudiante(estudiante) = estudiante.carrerasInscripto() 

    method laMateriaEstaEnCarrera(carrera,mat){
        /*
           PROPOSITO: indica si una materia se encuentro en la coleccion de materias de una carrera
        */
        return self.materiasEnCarrera(carrera).contains(mat)
    }

    method materiasEnCarrera(carrera) = carrera.materiasCarrera()

    //##### Materias de años anteriores  a la materiaActual

    method materiasDeAñosAnteriores(setMaterias,anhoMateria){
        
        return setMaterias.filter({m => self.esDeAñoAnterior(m)})
    }

    method esDeAñoAnterior(materia){
        return materia.anho()<anhoMateriaActual
    }

    // Resolucion del requisito
    method aproboTodasDeAñosAnterioresA(estudiante,setMaterias){
        return setMaterias.all({m => estudiante.tieneAprobada(m)})
        
    }


    

   




    


}
class Nada inherits Requisitos{
    override method cumpleRequisito(estudiante) = true
}




