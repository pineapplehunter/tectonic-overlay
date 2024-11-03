{
  stdenvNoCC,
  tectonic,
  cacert,
}:

{
  name,
  src,
  depsHash,
}:

stdenvNoCC.mkDerivation {
  inherit name src;

  nativeBuildInputs = [
    tectonic
    cacert
  ];
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    export XDG_CACHE_HOME=$out
    nextonic build
    rm -rfv $out/fontconfig
    runHook postInstall
  '';

  outputHash = depsHash;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}

