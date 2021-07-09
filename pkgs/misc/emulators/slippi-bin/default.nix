{ appimageTools, fetchurl, lib, glib-networking, vulkan-loader }:

let
  pname = "slippi-bin";
  version="2.3.1";
in
appimageTools.wrapType2 rec {
  name = "${pname}-${version}";

  extraPkgs = pkgs: with pkgs; [ gmp webkitgtk ];

  src = fetchurl {
    url = "https://github.com/project-slippi/Ishiiruka/releases/download/v${version}/Slippi_Online-x86_64.AppImage";
    sha256 = "0zz7zvnjp5s14wj4cri8ppkdvkiv095jpgql27xbmbzyx915qia4";
  };

  profile = ''
    export GIO_EXTRA_MODULES=${glib-networking}/lib/gio/modules
    export LD_LIBRARY_PATH=${vulkan-loader}/lib
  '';


  meta = with lib; {
    homepage = "https://slippi.gg/netplay";
    description = "Dolphin emulator customized for online melee netplay"; # TODO: improve
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ neonfuz ];
  };
}
