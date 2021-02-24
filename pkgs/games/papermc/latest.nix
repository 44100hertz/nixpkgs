{ lib, stdenv, bash, jre, curl, jq }:

stdenv.mkDerivation rec {
  pname = "papermc-latest";
  version = "1.17";

  dontUnpack = true;
  dontConfigure = true;

  buildPhase = ''
    cat > minecraft-server << EOF
    #!${bash}/bin/sh
    latest=\$(${curl}/bin/curl "https://papermc.io/api/v2/projects/paper/version_group/${version}/builds" | ${jq}/bin/jq .builds[-1])
    version=\$(echo "\$latest" | ${jq}/bin/jq -r .version)
    build=\$(echo "\$latest" | ${jq}/bin/jq -r .build)
    mkdir -p ./cache
    if [ ! -e ./cache/paper-\$version-\$build.jar ]; then
       rm -f ./cache/paper-*.jar
       ${curl}/bin/curl -o ./cache/paper-\$version-\$build.jar "https://papermc.io/api/v1/paper/\$version/\$build/download"
    fi
    exec ${jre}/bin/java \$@ -jar ./cache/paper-\$version-\$build.jar nogui
  '';

  installPhase = ''
    install -Dm555 -t $out/bin minecraft-server
  '';

  meta = {
    description = "High-performance Minecraft Server (latest ${version}.x build)";
    longDescription = ''
      Script which fetches and runs the latest papermc build compatible with
      minecraft ${version}.x. CLI is compatible with minecraft-server so this
      can be used as a target for services.minecraft-server.package.
    '';
    homepage    = "https://papermc.io/";
    license     = lib.licenses.gpl3Only;
    platforms   = lib.platforms.unix;
    maintainers = with lib.maintainers; [ neonfuz ];
  };
}
