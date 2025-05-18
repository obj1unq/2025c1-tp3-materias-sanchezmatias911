


/*manejo lista Espera*/

class Manejo{
    const materiaActual

    method alumnoAAñadir(){}

    method añadirAlumno(){

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

     
     const alumnoAniadir = materiaActual.listaDeEspera().first()

    override method añadirAlumno(){
        mateiaActual.añadirACursada(alumnoAniadir)

        materiaActual.

    }        
    
}