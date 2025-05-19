
class Manejo{
    const materiaActual

    method alumnoAInscribir()

    method actualizarListaEspera(){
        materiaActual.añadirACursada(self.alumnoAInscribir())

        self.quitarAlumnoEnListaDeEspera(self.alumnoAInscribir())
    }

    

    method quitarAlumnoEnListaDeEspera(estudiante){
        self.listaEspera().remove(estudiante)
    }

    method listaEspera() = materiaActual.listaDeEspera()

}



class Elitista inherits Manejo{
     
    override method alumnoAInscribir(){
        self.elDeMejorPromedio(self.listaEspera())
    }

    method elDeMejorPromedio(listaEspera){
        self.listaEspera().max({estudiante => estudiante.promedio()})
    }
}

class GradoAvance inherits Manejo{

     
    override method alumnoAInscribir(){
        self.listaEspera().max({estudiante => self.cantMateriasAprobadas(estudiante)})
    }

    method cantMateriasAprobadas(estudiante){
        return estudiante.materiasAprobadas().size()
    }

}
class OrdenLlegada inherits Manejo{

     override method alumnoAInscribir() = self.listaEspera().first()
   

     

   
}