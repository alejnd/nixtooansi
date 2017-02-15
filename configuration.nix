{
  network.description = "tooansi server";
  tooansi = 
    { config, pkgs, ... }:
    
    let
      packages = import ./default.nix { pkgs = pkgs; };
      tooansi = packages.tooansi;
      op = pkgs.lib;
    in
    { 
      networking.networkmanager.enable = true;
      services.sshd.enable = true;
      networking.firewall.allowedTCPPorts = [ 5000 22 ];
      networking.firewall.allowPing = true;
     
      systemd.services.tooansi = {
        after = [ "network.target" ];
        description = "tooansi Daemon";
        wantedBy = [ "default.target" ];
        serviceConfig = {

          Type = "simple";
          ExecStart = "${tooansi}/bin/tooansi";
          User = "tansi";
          Restart = "on-failure";
        };
      };
 
      users.extraUsers = {
        tansi = { };
      }; 
    };
}      
