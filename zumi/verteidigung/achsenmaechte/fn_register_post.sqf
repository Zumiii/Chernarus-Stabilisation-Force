/*

  Registriere später

*/

if !isServer exitWith {};

params [
  "_units"
];

{
  zumi_fahrzeuge pushBackUnique (vehicle _x);
  //registriere Gruppen
  (zumi_truppenteile select 1) pushBackunique (group _x);
  zumi_soldaten pushBackunique _x;
  //registriere Fahrzeuge

  switch (true) do {
    case ((vehicle _x) isKindOf "StaticMortar") : {
      zumi_moerser pushBack _x;
    };
    case ((vehicle _x) isKindOf "Car") : {
      (zumi_truppenteile select 2) pushBackunique (group _x);
      (zumi_truppenteile select 3) pushBackunique (group _x);

    };
    case ((vehicle _x) isKindOf "Tank") : {
      (zumi_truppenteile select 5) pushBackunique (group _x);
    };
    default {};
  };
  //registriere Kommandeure
  if ((typeOf _x) IN ["LOP_TKA_Infantry_Officer","LOP_AM_OPF_Infantry_SL"]) then {
    zumi_kommandeure pushBack _x;
  };
} forEach _units;
