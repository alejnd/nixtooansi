{ pkgs ? import <nixpkgs> {} }:

let
 python35Packages = pkgs.python35Packages;
in rec {
  tooansi = python35Packages.buildPythonApplication {
  version = "2.6";
  name = "tooansi";

  src = pkgs.fetchFromGitHub {
    owner = "alejnd";
    repo = "tooansi";
    rev = "ad1a3f281ffa8e1e590e5f922dc96e1cb276ed99";
    sha256 = "0m0z87ysha6zvgglxp4y07nc17x4h2pbkjqdr93f3rikzk1ylazs";
  };
  
  propagatedBuildInputs = with python35Packages; [ python flask pillow ];

  meta = {
    homepage = "https://github.com/alejnd/tooansi";
    description = "png to ansi rest service";
  };
 };
}
