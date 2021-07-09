{ appimageTools
, fetchurl
, lib
, glib-networking
, gmp
, vulkan-loader
, webkitgtk
}:

let
  command = "slippi-netplay";
  version="2.3.1";
in
appimageTools.wrapType2 rec {
  name = "${command}-bin-${version}";

  src = fetchurl {
    url = "https://github.com/project-slippi/Ishiiruka/releases/download/v${version}/Slippi_Online-x86_64.AppImage";
    sha256 = "0zz7zvnjp5s14wj4cri8ppkdvkiv095jpgql27xbmbzyx915qia4";
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
