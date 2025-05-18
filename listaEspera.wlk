


/*manejo lista Espera*/

class Manejo{
    const materiaActual

    method alumnoAAniadir()

    method añadirAlumno(){
        materiaActual.añadirACursada(self.alumnoAAniadir())

        self.quitarAlumnoEnListaDeEspera(self.alumnoAAniadir())
    }

    method quitarAlumnoEnListaDeEspera(estudiante){
        self.actualizarListaEspera(self.alumnoAAniadir())
    }

    method actualizarListaEspera(estudiante){
        self.listaEspera().remove(estudiante)
    }

    method listaEspera() = materiaActual.listaDeEspera()

}



class Elitista inherits Manejo{
     
    override method añadirAlumno(){}
}

class GradoAvance inherits Manejo{

     
    override method añadirAlumno(){}

}
class OrdenLlegada inherits Manejo{

     override method alumnoAAniadir() = materiaActual.listaDeEspera().first()
   //  const alumnoAniadir = materiaActual.listaDeEspera().first()

     

   
}