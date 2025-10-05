{ pkgs }: pkgs.stdenv.mkDerivation rec {
    pname = "apple-sf-mono";
    version = "1";

    src = pkgs.fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
        sha256 = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
    };

    nativeBuildInputs = [ pkgs.p7zip ];

    sourceRoot = ".";

    unpackPhase = ''
        runHook preUnpack

        7z x ${src}
        cd SFMonoFonts
        7z x 'SF Mono Fonts.pkg'
        7z x 'Payload~'
        cd ..

        runHook postUnpack
    '';

    installPhase = ''
        runHook preInstall

        install -m444 -Dt $out/share/fonts/opentype ./SFMonoFonts/Library/Fonts/*.otf

        runHook postInstall
    '';

    meta = with pkgs.lib; {
        description = "Apple's San Francisco Monospace font";
        homepage = "https://developer.apple.com/fonts/";
        license = licenses.unfree;
    };
}
