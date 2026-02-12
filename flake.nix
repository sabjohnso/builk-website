{
  description = "Development environment for the wile website (Hugo + Hextra)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.hugo
              pkgs.go
            ];

            shellHook = ''
              echo "wile-website dev shell"
              echo "  hugo $(hugo version 2>/dev/null | head -c 40)..."
              echo "  go   $(go version 2>/dev/null | cut -d' ' -f3)"
            '';
          };
        });
    };
}
