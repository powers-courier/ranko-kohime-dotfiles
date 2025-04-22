#!/usr/bin/env bash

echo -e "Running statix linter"
statix check

echo -e "Running deadnix to check for dead code"
deadnix

echo -e "Running nix flake check to ensure evaluation success"
nix flake check

