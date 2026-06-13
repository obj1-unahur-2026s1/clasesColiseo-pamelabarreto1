class ArmaDeFilo{
  const filo
  const longitud

  method ataque() = filo * longitud
}

class ArmaContundente{
  const peso

  method ataque() = peso
}

object casco{
  method proteccion(luchador) = 10
}
object escudo{
  method proteccion(luchador) = 5 + luchador.destreza() * 0.1
}

class Gladiador{
  var vida = 100

  method defensa()
  method fuerza()
  method destreza()
  method vida() = vida

  method atacar(unGladiador){
    unGladiador.recibirAtaque(self)
  }

  method recibirAtaque(unGladiador){
    vida = vida - (unGladiador.poderDeAtaque() - self.defensa())
  }

  method pelearCon(unGladiador){
    self.atacar(unGladiador)
    unGladiador.atacar(self)
  }

  method curar(){
    vida = 100
  }
}

class Mirmillon inherits Gladiador{
  var arma
  var armadura
  var fuerza

  method cambiarArma(unArma){arma=unArma}
  method cambiarArmadura(unaArmadura){armadura=unaArmadura}
  
  method cambiarFuerza(valor){fuerza=valor}
  override method fuerza() = fuerza
  override method destreza() = 15

  method poderDeAtaque() = fuerza + arma.ataque()

  override method defensa() = armadura.proteccion(self) + self.destreza()

  method formarGrupoCon(unGladiador){ return
    new Grupo(
      nombre="Mirmillolandia",
      miembros=#{unGladiador,self}
    )
  }
}

class Dimachaerus inherits Gladiador{
  const armas = []
  var destreza

  method agregar(unArma){armas.add(unArma)}
  method quitar(unArma){armas.remove(unArma)}

  override method fuerza() = 10
  override method destreza() = destreza

  method poderDeAtaque() = armas.sum({a=>a.ataque()}) + self.fuerza()

  override method defensa() = destreza/2
  
  override method atacar(unGladiador){
    super(unGladiador)
    destreza += 1
  }

  method formarGrupoCon(unGladiador){return
    new Grupo(
      nombre="D-" + (self.poderDeAtaque()+unGladiador.poderDeAtaque()).toString(),
      miembros=#{unGladiador,self}
    )
  }
}

class Grupo{
  const property miembros = #{}
  const property nombre
  var cantPeleas = 0

  method agregar(unGladiador){miembros.add(unGladiador)}
  method quitar(unGladiador){miembros.remove(unGladiador)}

  method puedenCombatir() = miembros.filter({m=>m.vida() > 0})
  method campeon() = self.puedenCombatir().max({m=>m.poderDeAtaque()})

  method combatirCon(unGrupo){
    self.campeon().pelearCon(unGrupo.campeon())
    self.campeon().pelearCon(unGrupo.campeon())
    self.campeon().pelearCon(unGrupo.campeon())
    cantPeleas+=3
  }
}

object coliseo{
  method organizarCombate(unGrupo,otroGrupo){
    unGrupo.combatirCon(otroGrupo)
  }

  method organizarCombateContraGladiador(unGrupo,unGladiador){
    unGrupo.forEach({g=>g.pelearCon(unGladiador)})
  }

  method curar(unGladiador){
    unGladiador.curar()
  }

  method curarGrupo(unGrupo){
    unGrupo.miembros().forEach({g=>g.curar()})
  }
}
// class ArmaDeFilo{
//   const filo
//   const longitud

//   method ataque() = filo * longitud

// }

// class ArmaContundente {
//   const peso

//   method ataque() =peso 
// }

// object casco {
//   method defensa(luchador) =10 
// }
// object escudo {

//   method defensa(luchador) = 5 + luchador.destreza()

// }

// class Gladiador {
//   var vida=100

//   method atacar(unGladiador) {
//     const daño= self.poderDeAtaque()- unGladiador.defensa()
// unGladiador.perderVida(daño)
//   }
//   method perderVida(cant) {vida-cant} 
//   method defenderse() {}
//   method pelearCon(unGladiador){
//     self.atacar(unGladiador)
//     unGladiador.atacar(self)
//   }

//   method vida() =vida 
//   method curar() {vida=100}
// }


// class Mirmillones inherits Gladiador{
// var armadura
// var fuerza
// var arma
// method destreza() =15 
// method fuerza() =fuerza
// method cambiarFuerza(cant) {fuerza= fuerza + cant}
// method cambiarArma(unArma) {arma=unArma}
// method cambiarArmadura(unaArmadura) {armadura=unaArmadura}
//  method defensa() =armadura.defensa(self) + self.destreza() 

// override method poderDeAtaque() = fuerza + arma.ataque()

// method crearGrupoCon(otroGladiador) {
//   const nuevoGrupo= new Grupo(nombre="mirmillolandia")
//   nuevoGrupo.agregar(self)
//   nuevoGrupo.agregar(otroGladiador)
//   return nuevoGrupo
// }



// }

// class Dimachaerus inherits Gladiador{
// const armas= []
// var destreza
// method fuerza() =10
// method agregarArma(unArma) =armas.add(unArma) 
// method quitarArma(unArma) =armas.remove(unArma) 
// override method atacar(unGladiador){ super(unGladiador)
// destreza+=1

// }

// method defensa() = destreza/2 
// method poderDeAtaque() =self.fuerza() + armas.sum({a=>a.ataque()}) 

// }
// class Grupo{
// const nombre
// var cantPeleas=0
// const miembros=#{}

// method agregar(unGladiador) {miembros.add(unGladiador)}
// method quitar(unGladiador) {miembros.remove(unGladiador)}
// method puedeCombatir(unGladiador) = unGladiador.vida()>0
// method puedenCombatir() =miembros.filter({g=>g.vida()>0})
// method campeon() =  self.puedenCombatir().max({g=>g.fuerza()})

// method crearGrupoCon(otroGladiador) {
//   return  new Grupo
//   nombre= "D" + (Self.poderDeAtaque()+ otroGladiador.poderDeAtaque()).toString()
//   miembros=(self,otroGladiador)



// }
// method combatirCon(otroGrupo) {
//   self.campeon().pelearCon(otroGrupo.campeon())
//   self.campeon().pelearCon(otroGrupo.campeon())
//   self.campeon().pelearCon(otroGrupo.campeon())
//   cantPeleas+=3
// }

//  }

// object coliseo {
//   method combatirGrupos(grupo1,grupo2){
//     grupo1.combatirCon(grupo2)

//   } 
//   method combatirContraCampeon(unGrupo,unCampeon) {
//     unGrupo.miembros().forEach({g=>g.pelearCon(unCampeon)})
//   }
//   method curarGrupo(unGrupo) {
//     unGrupo.miembros().forEach({g=>g.curar()})
//   }
//   method curarGladiador(unGladiador) {
//     unGladiador.forEach({g=>g.curar()})
//   }
   
// }