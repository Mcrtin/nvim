{ lib
, nixvim
, ...
}:
let
  additions = final: _prev:
    import ../pkgs {
      inherit nixvim;
      inherit (final) system;
    };
in
lib.composeManyExtensions [ additions ]
