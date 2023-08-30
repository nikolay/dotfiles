{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
  ];

  users.users.nikolay = {
    name = "nikolay";
    home = "/Users/nikolay";
  };
  home-manager.users.nikolay = {pkgs, ...}: {
    home.packages = with pkgs; [
      alejandra
    ];
    home.stateVersion = "23.05";
  };

  services.nix-daemon.enable = true;
  nix.extraOptions = ''
    extra-nix-path = nixpkgs=flake:nixpkgs
    build-users-group = nixbld
    experimental-features = nix-command flakes auto-allocate-uids
  '';
  nixpkgs.hostPlatform = {
    config = "aarch64-apple-darwin";
    system = "aarch64-darwin";
  };

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
