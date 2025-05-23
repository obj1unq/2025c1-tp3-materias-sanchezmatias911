
import inscripciones_CON_bonus.*
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
             (not self.tieneAprobada(materia)) and
             (not self.estaInscripto(materia)) and
             materia.cumpleRequisitos(self)

    }

    method materiaEnCarrera(materia){
        return self.materiasDeTodasLasCarreras().contains(materia)
    }

    method estaInscripto(materia){
        return materia.alumnosInscriptos().contains(self)
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

    method mensajeInscripto(materia) = "Usted esta inscripto a la materia" + materia.nombre()

    method mensajeListaEspera(materia) = "Usted esta en la lista de espera de la materia: "+ materia.nombre()

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

    method aproboCorrelativas(materia){
        return materia.correlativas().all({materia => self.tieneAprobada(materia)})
    }
    
    method aproboTodasDeAñosAnterioresA(setMaterias){
        return setMaterias.all({m => self.tieneAprobada(m)})
        
    }
}


