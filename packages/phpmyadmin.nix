{ pkgs }: pkgs.php.buildComposerProject2 (finalAttrs: {
    pname = "phpmyadmin";
    version = "5.2.3";

    vendorHash = "sha256-NjynqtLrKyCpiFVzHfbw2+Q0VzccIfo2GLz05Y/GBW0=";
    composerStrictValidation = false;

    src = pkgs.fetchFromGitHub {
        owner = "phpmyadmin";
        repo = "phpmyadmin";
        rev = "RELEASE_5_2_3";
        sha256 = "sha256-K9k4l7OHhs1KTPRPBegZ+7JMQDfTHkEb1bbsO15Bm5c=";
    };

    yarnOfflineCache = pkgs.fetchYarnDeps {
        yarnLock = finalAttrs.src + "/yarn.lock";
        sha256 = "sha256-PIHLqlL/+DTtdHTL0Kd1C1ZbJhn83NguHD4lx8iyb/4=";
    };

    nativeBuildInputs = with pkgs; [
        nodejs
        yarn
        yarnConfigHook
        yarnInstallHook
    ];

    postInstall = ''
        cd "$out/share/php/phpmyadmin"
        yarn run postinstall
    '';
})
