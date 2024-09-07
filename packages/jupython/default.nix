{ pkgs, ... }:
pkgs.buildEnv {
  name = "jupython";
  paths = with pkgs; [
    (python3.withPackages(ps: with ps; [
      ipython
      jupyter
      numpy
      matplotlib
      pandas
    ]))
  ];
}
