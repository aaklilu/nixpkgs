{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dbip-asn-lite";
  version = "2025-04";

  src = fetchurl {
    url = "https://download.db-ip.com/free/dbip-asn-lite-${finalAttrs.version}.mmdb.gz";
    hash = "sha256-gAMetVcoeTmXUYELzplAjz2Rk5p4tY4+NnCmmotUN0o=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preBuild

    gzip -c -d "$src" > dbip-asn-lite.mmdb
    install -Dm444 dbip-asn-lite.mmdb "$out/share/dbip/dbip-asn-lite.mmdb"

    runHook postBuild
  '';

  passthru.mmdb = "${finalAttrs.finalPackage}/share/dbip/dbip-asn-lite.mmdb";

  meta = {
    description = "Free IP to ASN Lite database by DB-IP";
    homepage = "https://db-ip.com/db/download/ip-to-asn-lite";
    license = lib.licenses.cc-by-40;
    maintainers = with lib.maintainers; [ Guanran928 ];
    platforms = lib.platforms.all;
  };
})
