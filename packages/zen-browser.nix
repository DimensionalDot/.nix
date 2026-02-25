{ stdenv, lib, fetchFromGitHub, nodejs_24 }: stdenv.mkDerivation rec {
    pname = "zen-browser";
    version = "0.1";

    src = fetchFromGitHub {
        owner = "zen-browser";
        repo = "desktop";
        rev = "1.16.3b";
        sha256 = "0ljsq892psfpz0yl23c2j34pfksqdr2cjk2bba6kk2l570xqvgx1";
    };

    buildPhase = ''
        npm i
    '';

    dontFixup = true;

    meta = with lib; {
        description = "Zen Browser";
        homepage = "https://zen-browser.app/";
        license = licenses.mpl20;
    };
}
