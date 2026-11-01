fmt:
    alejandra .
    shfmt -w .

dedup:
    nix store optimise

update:
    nix flake update

switch:
    sudo nixos-rebuild switch --flake /home/jamesa/projects/nixos-config#framework

