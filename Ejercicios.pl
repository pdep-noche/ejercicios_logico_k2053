transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).

tardaMucho(Persona):-transporte(Persona, camina).
tardaMucho(Persona):-transporte(Persona, auto(_, _, _)), manejaLento(Persona).

viajaEnColectivo(Persona):- transporte(Persona, Transporte), 
            esColectivo(Transporte).

esColectivo(colectivo(_, _)).
esColectivo(colectivo(_)).%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,4,500)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(garaje,600)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


puedeIr(Persona, Lugar, Alojamiento):- lugar(Lugar, Alojamiento), 
    puedeGastar(Persona, CantDias, Disponible),  cumpleCondiciones(Alojamiento, MontoDia),
    Disponible >= CantDias * MontoDia.


cumpleCondiciones(hotel(_, Estrellas, MontoDia), MontoDia):- Estrellas > 3.
cumpleCondiciones(quinta(_, pileta, MontoDia), MontoDia).
cumpleCondiciones(casa(garaje, MontoDia), MontoDia).
cumpleCondiciones(carpa(MontoDia), MontoDia).

puedeIrACualquierLugar(Persona):-puedeGastar(Persona, _, _), 
forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).

genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soleLeGustaPeliculasDeGenero(Persona, Genero):-gusta(Persona, _), 
    genero(_,Genero),forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).


peliculasQueLeGustaPorGenero(Persona, Genero, Peliculas):- gusta(Persona, _), 
    genero(_, Genero), findall(Pelicula, gustaPeliculaPersona(Pelicula, Persona, Genero), Peliculas).

gustaPeliculaPersona(Pelicula, Persona, Genero):- gusta(Persona, Pelicula), genero(Pelicula, Genero).

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

loLiquidaron(Jugador):- jugador(Jugador), not(ocupa(_, Jugador,_)).

ocupaContinente(Jugador, Continente):- jugador(Jugador), continente(Continente), 
    forall(estaEn(Continente, Pais), ocupa(Pais, Jugador, _)).