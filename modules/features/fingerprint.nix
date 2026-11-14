_: {
  flake.nixosModules.fingerprint = {lib, ...}: {
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = lib.mkForce false;
  };
}
