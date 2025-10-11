let
  inherit (import ./vars.secret.nix) secret_paths secret_sshHosts secret_rdpHosts secret_userContentDir secret_specialPkgs secret_openWebUiKey;
in
{

  # format: variableScope_moduleName_variableName 


  minimalText = false;
  paths = secret_paths;
  specialPkgs = secret_specialPkgs;

  # alias
  mod_alias_sshHosts = secret_sshHosts;
  mod_alias_rdpHosts = secret_rdpHosts;

  # environment
  mod_environment_textEditor = "nvim";
  mod_environment_ps1Color = "36";
  mod_environment_openWebUiKey = secret_openWebUiKey;

  # settings/gnome
  mod_gnome_accentColor = "blue";
  mod_gnome_kbSources = [ "us+colemak_dh" "us" ];
  mod_gnome_kbOptions = [ "terminate:ctrl_alt_bksp" "caps:swapescape" ];

  # settings/kde-gruv
  mod_kdeGruv_userContentDir = secret_userContentDir;

}
