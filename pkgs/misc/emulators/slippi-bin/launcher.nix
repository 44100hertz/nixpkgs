{ appimageTools
, fetchurl
, lib
, glib-networking
, gmp
, vulkan-loader
, webkitgtk
}:

let
  command = "slippi-launcher";
  version="2.0.2";
in
appimageTools.wrapType2 rec {
  name = "${command}-bin-${version}";

  src = fetchurl {
    url = "https://github.com/project-slippi/slippi-launcher/releases/download/v${version}/Slippi-Launcher-${version}-x86_64.AppImage";
    sha256 = "080rjma824ilzdlbz4w3yrcv1r2idr4iyajyxwl49xyqbyhdbwxa";
  };
  extraPkgs = pkgs: [
    gmp
    glib-networking
    vulkan-loader
    webkitgtk
  ];
  extraInstallCommands = ''
    mv $out/bin/{${name},${command}}
  '';

  meta = with lib; {
    homepage = "https://slippi.gg/netplay";
    description = "Emulator customized for Super Smash Bros Melee netplay";
    longDescription = ''
      The dolphin gamecube emulator modified to add extra functionality to
      Super Smash Bros Melee netplay. Features include rollback netplay,
      matchmaking, replay saving, and more.
    '';
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ neonfuz ];
  };
}
