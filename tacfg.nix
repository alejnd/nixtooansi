{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.tooansi;

in {
  options.services.tooansi = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
        By default the service is disabled
      '';
     };
  };
    config = mkIf cfg.enable {
      systemd.services.tooansi = {
        after = [ "network.target" ];
        description = "tooansi Daemon";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.tooansi}/bin/tooansi";
          Restart = "always";
        };
      };
    };
}
