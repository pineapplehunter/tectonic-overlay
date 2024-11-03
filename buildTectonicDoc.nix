{
  fetchTectonicDeps,
  stdenvNoCC,
  tectonic,
}:

{
  name,
  src,
  depsHash ? "",
  tectonicDeps ? fetchTectonicDeps {
    name = "${name}-deps";
    inherit src depsHash;
  },
  nativeBuildInputs ? [ ],
  ...
}@args:

stdenvNoCC.mkDerivation (
  {
    inherit name src tectonicDeps;
    nativeBuildInputs = [ tectonic ] ++ nativeBuildInputs;

    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      runHook preInstall
      export XDG_CACHE_HOME=$tectonicDeps
      nextonic build
      mv build $out
      runHook postInstall
    '';
  }
  // builtins.remove args [
    "name"
    "src"
    "nativeBuildInputs"
    "depsHash"
  ]
)
