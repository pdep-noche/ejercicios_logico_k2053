%1
%creeEn(Persona, Personaje).
creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

%quiere(Persona,Sueño).
quiere(gabriel, ganarLoteria([5,9])).
quiere(gabriel, futbolista(arsenal)).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

persona(Persona):-quiere(Persona, _).
%2
esAmbiciosa(Persona):-persona(Persona), sumaTotalDificultades(Persona, Total), Total >20.

sumaTotalDificultades(Persona, Total):-findall(Dificultad, dificultad(Persona, Dificultad) , ListaDificultades), 
    sumlist(ListaDificultades, Total).

dificultad(Persona, Dificultad):-quiere(Persona, Suenio), nivelDificultad(Suenio, Dificultad).

nivelDificultad(cantante(CantDiscos), 6):- CantDiscos > 500000.
nivelDificultad(cantante(CantDiscos), 4):- CantDiscos =< 500000.
nivelDificultad(ganarLoteria(Numeros), Dificultad):- length(Numeros, Cantidad), 
    	Dificultad is Cantidad *10.
nivelDificultad(futbolista(Equipo), 3):- equipoChico(Equipo).
nivelDificultad(futbolista(Equipo), 16):- not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%3
tieneQuimica(Personaje, Persona):-creeEn(Persona, Personaje),cumpleCondiciones(Persona, Personaje).

cumpleCondiciones(Persona, campanita):-dificultad(Persona, Dificultad), Dificultad < 5.
cumpleCondiciones(Persona, Personaje):- Personaje \= campanita, todosLosSueniosPuros(Persona), 
                                     not(esAmbiciosa(Persona)).

todosLosSueniosPuros(Persona):- forall(quiere(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(CantDiscos)):- CantDiscos < 200000.

%4
puedeAlegrar(Personaje, Persona):-quiere(Persona, _), tieneQuimica(Personaje, Persona), 
    cumpleCondicionParaAlegrar(Personaje).

cumpleCondicionParaAlegrar(Personaje):-not(enfermo(Personaje)).
cumpleCondicionParaAlegrar(Personaje):- backup(Personaje, Backup), 
    	            cumpleCondicionParaAlegrar(Backup).

backup(Personaje, OtroPersonaje):-amigo(Personaje, OtroPersonaje).
backup(Personaje, OtroPersonaje):-amigo(Personaje, Backup), 
    					backup(Backup, OtroPersonaje).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).

amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePacua, cavenaghi).

%Trabajadores Estresantes
%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).

%tarea(persona, tipoTarea, fecha)
tarea(dani, tomarExamen(paradigmaLogico, aula522), fecha(10/08/2019)).
tarea(dani, meterGol(primeraDivision), fecha(10/08/2019)).
tarea(alf, hacerDiscurso(utn, 0), fecha(11/08/2019)).

%nacioEn(persona, lugar).
nacioEn(dani, caba).
nacioEn(alf, caba).
nacioEn(nico, caba).


%1
nuncaSalioDeCasa(Persona):-nacioEn(Persona, Lugar), 
    forall(tarea(Persona, Tarea, _), lugar(Tarea, Lugar)).

lugar(hacerDiscurso(Lugar, _), Lugar).
lugar(tomarExamen(_, Lugar), Lugar).
lugar(meterGol(Torneo), Lugar):- seJuegaEn(Torneo, Lugar).

seJuegaEn(primeraDivision, argentina).
