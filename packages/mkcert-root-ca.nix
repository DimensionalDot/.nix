{ pkgs }: pkgs.stdenv.mkDerivation rec {
    pname = "mkcert-root-ca";
    version = "1";

    buildCommand = ''
        runHook preInstall

        mkdir $out
        cd $out
        CAROOT="." ${pkgs.mkcert}/bin/mkcert -install

        runHook postInstall
    '';
}
