[
  (self: super: with super; {
    custom-overlays = {
      emacs27 = (callPackage ../pkgs/emacs27.nix {});
    };
  })

  # emacsGit
  (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))

]
