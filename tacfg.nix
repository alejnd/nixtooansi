{ config, pkgs, ... }:
with pkgs.lib;

let
  cfg = config.services.tooansi;

in {
  options.services.tooansi = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        By default the service is disabled
      '';
     };
  };
    config = {
      systemd.services.tooansi = {
        after = [ "network.target" ];
        description = "tooansi Daemon";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.tooansi}/bin/tooansi";
          Restart = "on-failure";
        };
      };
    };
}
