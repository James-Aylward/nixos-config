{...}: {
  flake.nixosModules.fingerprint = {lib, ...}: {
    services.fprintd.enable = true;
    security.pam.services.greetd.fprintAuth = lib.mkForce false;
    security.pam.services.login.fprintAuth = lib.mkForce false;
  };
}
