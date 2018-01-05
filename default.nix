self: super:
rec {
  diffoscope = super.diffoscope.override { enableBloat = true; };
  freedoko = super.callPackage ./freedoko.nix {};
}
