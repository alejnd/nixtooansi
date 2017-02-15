{
  network.description = "tooansi server";
  tooansi = 
    { config, pkgs, ... }:
    
    let
      packages = import ./default.nix { pkgs = pkgs; };
      tooansi = packages.tooansi;
    in
    { 
      networking.networkmanager.enable = true;
      services.sshd.enable = true;
      networking.firewall.enable = false;
      networking.firewall.allowedTCPPorts = [ 5000 22 ];
      networking.firewall.allowPing = true;
      networking.interfaces.eth0.ip4 = [ { address = "192.168.1.200"; prefixLength = 24; } ];
      networking.defaultGateway = "192.168.1.1";
      networking.nameservers = [ "8.8.8.8" ];
      
 #     options.services.tooansi = {
 #       enable = mkOption {
 #       type = types.bool;
 #       default = false;
 #       description = ''
 #       By default the service is disabled
 #       '';
 #       };
 #     };
  
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
