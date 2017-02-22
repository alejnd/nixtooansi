with import <nixpkgs> {};

python35Packages.buildPythonApplication rec {
  version = "1.0";
  name = "tooansi";

  src = fetchFromGitHub {
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
}
