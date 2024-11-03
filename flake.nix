{
  description = "A basic shell";

  inputs = { };

  outputs =
    { ... }:
    {
      overlays.default = final: prev: {
        fetchTectonicDeps = final.callPackage ./fetchTectonicDeps.nix { };
        buildTectonicDoc = final.callPackage ./buildTectonicDoc.nix { };
      };
    };
}
