{ 
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    ( final: prev:  {
        yazi = prev.yazi.override {
            _7zz = pkgs._7zz-rar;
        };
    })
  ];

  programs.yazi = {
    enable = true;

    settings = {
      mgr = {
        sort_by = "extension";
        sort_sensitive=false;
        sort_dir_first=true;
      };
    };
  };

  xdg.mimeApps = {
    defaultApplications = {
      "inode/desktop" = "yazi.desktop";
    };
  };
}
