{
  network.description = "Tooansi server";
  taserver =
    { config, pkgs, ... }:
    with pkgs.lib;

    {
      nixpkgs.config = {
        packageOverrides = {
          tooansi = import ./tooansi.nix;
        };
      };

      environment.systemPackages = [ pkgs.tooansi ];
      imports = [ <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix> 
                  ./tacfg.nix
                ];

      networking.firewall.allowedTCPPorts = [ 5000 22 ];
      networking.firewall.allowPing = true;
      networking.networkmanager.enable = true;
      security.sudo.wheelNeedsPassword = false;
      services.sshd.enable = true;
      services.tooansi = true;

      users.extraUsers = {
        tansi = { }; 
     };

     users.extraUsers.nixuser = {
       extraGroups = [ "wheel" ];
       isNormalUser = true;
       openssh.authorizedKeys.keys = [ "ssh-rsa YOUR PUBLIC KEY you@your-machine" ];
       };
     };
}
