{ config, pkgs, lib, home, ... }:

{

  home.packages = with pkgs; [
    kitty
  ];

  # old config, I don't use kitty anymore
  home.file."${home}/.config/kitty/kitty.conf".text = ''
    background_opacity 0.78
    font_size 9.5
    enable_audio_bell no
    
    font_size_increment 0.1
    map ctrl+= increase_font_size
    map ctrl+- decrease_font_size
    
    map page_up remote_control scroll-window 1p-
    map page_down remote_control scroll-window 1p
    
    map shift+page_up scroll_line_up
    map shift+page_down scroll_line_down
    
    map ctrl+t new_tab_with_cwd
    map ctrl+w close_tab
    
    map alt+tab next_tab
    map alt+shift+tab previous_tab
    
    tab_bar_edge top
    tab_bar_style custom 
    tab_bar_background #000000

    map alt+1 goto_tab 1
    map alt+2 goto_tab 2
    map alt+3 goto_tab 3
    map alt+4 goto_tab 4
    map alt+5 goto_tab 5
    map alt+6 goto_tab 6
    map alt+7 goto_tab 7
    map alt+8 goto_tab 8
    map alt+9 goto_tab 9
    
    enabled_layouts vertical
    map ctrl+shift+t new_window_with_cwd
    
    map shift+left move_window up 
    map shift+right move_window down
    
    map shift+up neighboring_window up
    map shift+down neighboring_window down
    
    map ctrl+shift+up resize_window taller
    map ctrl+shift+down resize_window shorter
    
    confirm_os_window_close 0
    
    map ctrl+shift+0 change_font_size reset
  '';

}
