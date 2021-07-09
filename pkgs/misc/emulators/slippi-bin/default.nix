{ appimageTools, fetchurl, lib, glib-networking, vulkan-loader }:

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
  extraPkgs = pkgs: with pkgs; [
    glib-networking
    gmp
    vulkan-loader
    webkitgtk
  ];
  extraInstallCommands = ''
    mv $out/bin/{${name},${command}}
  '';

  meta = with lib; {
    homepage = "https://slippi.gg/netplay";
    description = "Dolphin emulator customized for online melee netplay"; # TODO: improve
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ neonfuz ];
  };
}
