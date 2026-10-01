{ lib, writeShellApplication, coreutils, herdr, jq, tuicr }:

writeShellApplication {
  name = "tuicr-herdr";

  runtimeInputs = [ coreutils herdr jq tuicr ];

  text = builtins.readFile ./tuicr-herdr.sh;

  meta = {
    description = "Review changes in a Herdr tab and submit feedback to the originating agent";
    mainProgram = "tuicr-herdr";
    platforms = lib.platforms.unix;
  };
}
