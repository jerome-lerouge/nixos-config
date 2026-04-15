# overlays/claude-code.nix
final: prev: {
  claude-code = prev.claude-code.overrideAttrs (old: rec {
    version = "2.1.85"; # la nouvelle version

    src = prev.fetchurl {
      url = "https://example.com/claude-desktop-${version}.tar.gz";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      # ↑ commence par mettre un hash vide ou faux,
      # Nix t'indiquera le bon à la première tentative de build
    };
  });
}
