{ config, pkgs, lib, inputs, ... }:

{
  hjem.users.lptlv = {
    clobberFiles = true;
    user = "lptlv";
    directory = "/home/lptlv";

    files = {
      # GTK Icons and Cursor
      ".config/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-theme-name=Chicago95
        gtk-icon-theme-name=Chicago95
        gtk-font-name=ANAKRON Nerd Font Medium 11
        gtk-cursor-theme-name=macOS-White
        gtk-cursor-theme-size=24
        gtk-toolbar-style=GTK_TOOLBAR_ICONS
        gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
        gtk-button-images=0
        gtk-menu-images=0
        gtk-enable-event-sounds=1
        gtk-enable-input-feedback-sounds=1
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle=hintslight
        gtk-xft-rgba=rgb
        gtk-application-prefer-dark-theme=1
     '';
     ".config/gtk-4.0/settings.ini".text = ''
       [Settings]
       gtk-theme-name=Chicago95
       gtk-icon-theme-name=Chicago95
       gtk-font-name=ANAKRON Nerd Font Medium 11
       gtk-cursor-theme-name=macOS-White
       gtk-cursor-theme-size=24
       gtk-toolbar-style=GTK_TOOLBAR_ICONS
       gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
       gtk-button-images=0
       gtk-menu-images=0
       gtk-enable-event-sounds=1
       gtk-enable-input-feedback-sounds=1
       gtk-xft-antialias=1
       gtk-xft-hinting=1
       gtk-xft-hintstyle=hintslight
       gtk-xft-rgba=rgb
       gtk-application-prefer-dark-theme=1
     '';
     ".config/xsettingsd/xsettingsd.conf".text = ''
       Net/ThemeName "Chicago95"
       Net/IconThemeName "Chicago95"
       Gtk/CursorThemeName "macOS-White"
       Net/EnableEventSounds 1
       EnableInputFeedbackSounds 1
       Xft/Antialias 1
       Xft/Hinting 1
       Xft/HintStyle "hintslight"
       Xft/RGBA "rgb"
     '';

     ### MangoWM
     # config.conf
     ".config/mango/config.conf".text = ''
#     Misc
       focus_on_activate=1
       sloppyfocus=1
       warpcursor=1
       focus_cross_monitor=0
       focus_cross_tag=0
       enable_floating_snap=0
       snap_distance=30
       drag_tile_to_tile=1

#     Key Bindings
       keymode=default
#     Reload config & settings
       bind=SUPER+SHIFT,r,reload_config
       bind=SUPER+SHIFT,r,spawn,mangowarn
       bind=SUPER,c,spawn,foot --app-id nix-up sysettings
       bind=ALT,c,spawn,foot --app-id manset mangosettings
       bind=ALT,s,spawn,noctalia msg settings-toggle

#     Menu and terminal
       bind=SUPER,space,spawn,noctalia msg panel-toggle launcher
       bind=SUPER,Return,spawn,foot

#     Exit
       bind=SUPER,BackSpace,killclient,
       bind=none,XF86PowerOff,spawn,noctalia msg panel-toggle session

#    ### WINDOW MANAGING

#         Switch window focus
           bind=SUPER,Tab,focusstack,next
           bind=SUPER,Left,focusdir,left
           bind=SUPER,Right,focusdir,right
           bind=SUPER,Up,focusdir,up
           bind=SUPER,Down,focusdir,down

#         Swap window
           bind=SUPER+SHIFT,Up,exchange_client,up
           bind=SUPER+SHIFT,Down,exchange_client,down
           bind=SUPER+SHIFT,Left,exchange_client,left
           bind=SUPER+SHIFT,Right,exchange_client,right

#         Switch window status
           bind=SUPER,g,toggleglobal,
           bind=ALT,Tab,spawn,wswitch next
           bind=ALT+SHIFT,Tab,spawn,wswitch prev
           bind=ALT,backslash,togglefloating,
           bind=ALT,a,togglemaximizescreen,
           bind=SUPER,f,togglefloating,
           bind=ALT+SHIFT,f,togglefakefullscreen,
           bind=SUPER,o,toggleoverlay,
           bind=SUPER+SHIFT,m,restore_minimized
           bind=SUPER,z,toggle_scratchpad
           bind=SUPER,m,minimized,

#         Move & resize windows
           bind=CTRL+SHIFT,Up,movewin,+0,-50
           bind=CTRL+SHIFT,Down,movewin,+0,+50
           bind=CTRL+SHIFT,Left,movewin,-50,+0
           bind=CTRL+SHIFT,Right,movewin,+50,+0
           bind=CTRL+ALT,Up,resizewin,+0,-50
           bind=CTRL+ALT,Down,resizewin,+0,+50
           bind=CTRL+ALT,Left,resizewin,-50,+0
           bind=CTRL+ALT,Right,resizewin,+50,+0

#    ### TAG MANAGING

#         Tag switch
           tag_carousel=1
           bind=ALT,Left,viewtoleft,0
           bind=ALT,Right,viewtoright,0
           bind=CTRL,Left,viewtoleft_have_client,0
           bind=CTRL,Right,viewtoright_have_client,0
           bind=CTRL+SUPER,Left,tagtoleft,0
           bind=CTRL+SUPER,Right,tagtoright,0

           bind=SUPER,1,view,1,0
           bind=SUPER,2,view,2,0
           bind=SUPER,3,view,3,0
           bind=SUPER,4,view,4,0
           bind=SUPER,5,view,5,0
           bind=SUPER,6,view,6,0
           bind=SUPER,7,view,7,0
           bind=SUPER,8,view,8,0
           bind=SUPER,9,view,9,0

           bind=Alt,1,tag,1,0
           bind=Alt,2,tag,2,0
           bind=Alt,3,tag,3,0
           bind=Alt,4,tag,4,0
           bind=Alt,5,tag,5,0
           bind=Alt,6,tag,6,0
           bind=Alt,7,tag,7,0
           bind=Alt,8,tag,8,0
           bind=Alt,9,tag,9,0

#    ### SYSTEM

#         Screenshot & Screencast
           bind=none,Print,spawn, msnap gui

#         Key applications
           bind=none,XF86Calculator,spawn,gtk-launch arch-qalculate-gtk.desktop
           bind=none,XF86Launch2,spawn,noctalia msg panel-toggle calendar

#         Volume
           bind=none,XF86AudioRaiseVolume,spawn,noctalia msg volume-up
           bind=none,XF86AudioLowerVolume,spawn,noctalia msg volume-down
           bind=none,XF86AudioMute,spawn,noctalia msg volume-mute

#         Media
           bind=none,XF86AudioMedia,spawn,noctalia msg media toggle
           bind=none,XF86AudioPlay,spawn,noctalia msg media toggle
           bind=none,XF86AudioPrev,spawn,noctalia msg media previous
           bind=none,XF86AudioNext,spawn,noctalia msg media next

#         Brightness
           bind=none,XF86MonBrightnessUp,spawn,noctalia msg brightness-up
           bind=none,XF86MonBrightnessDown,spawn,noctalia msg brightness-down

#     Sources
       source =~/.config/mango/env.conf
       source =~/.config/mango/autostart.sh
       source =~/.config/mango/peripherics.conf
       source =~/.config/mango/layouts.conf
       source =~/.config/mango/appearance.conf
       source =~/.config/mango/noctalia.conf
       source =~/.config/mango/rules.conf
       source =~/.config/mango/noctalia.conf
     '';

     # rules.conf
     ".config/mango/rules.conf".text = ''
#     Window Rules

#       Specific Tags
         windowrule=tags:3,appid:gnome-commander
         windowrule=istagsilent:1,tags:4,appid:floorp
         windowrule=istagsilent:1,isopensilent:1,tags:6,appid:vesktop

         windowrule=istagsilent:1,tags:7,appid:exe+
         windowrule=istagsilent:1,tags:7,appid:steam_app+
         windowrule=istagsilent:1,tags:7,appid:Weiss+
         windowrule=istagsilent:1,tags:7,appid:prismlauncher
         windowrule=istagsilent:1,tags:8,appid:steam
         windowrule=istagsilent:1,tags:8,appid:lutris
         windowrule=istagsilent:1,tags:9,appid:spotify

#       Floating
         windowrule=isfloating:1,appid:qalculate
         windowrule=isfloating:1,appid:nix-up
         windowrule=isfloating:1,appid:manset
	 windowrule=isfloating:1,appid:tuiset

#       Layer Rules
         layerrule=noanim:1,layer_name:wswitch
         layerrule=animation_type_open:fade,animation_type_close:none,noblur:1,layer_name:msnap
         layerrule=noblur:1,layer_name:selection

#       Tag Rules

#       Window Rules

#       Scratchpads
         bind=SUPER,s,setkeymode,scratchpad
         keymode=scratchpad

#       Spotify
         windowrule=isnamedscratchpad:1,appid:spotify
         bind=none,s,toggle_named_scratchpad,spotify,none,spotify
         bind=none,s,setkeymode,default

#       Text Editor
         windowrule=isnamedscratchpad:1,width:1000,height:700,appid:foot-flow
         bind=none,f,toggle_named_scratchpad,foot-flow,none,foot --app-id foot-flow flow
         bind=none,f,setkeymode,default

     '';

     # autostart.sh
     ".config/mango/autostart.sh".text = ''
#     UI Environment
       exec-once=systemctl --user reset-failed noctalia.service
       exec-once=systemctl --user start noctalia.service
       exec-once=dbus-update-activation-environment --systemd
       exec-once=wswitch --daemon
       exec-once=echo "Xft.dpi: 140" | xrdb -merge
       exec-once=sudo /home/lptlv/Scripts/syscleanup
     '';

     # appearance.conf
     ".config/mango/appearance.conf".text = ''
#     Appearance

#       Borders
         borderpx=3
         focuscolor=0xe8b8a8ff
         bordercolor=0x00000000
         rootcolor=0x201b14ff
         maximizescreencolor=0xe67e80ff
         urgentcolor=0xdbbc7fff
         no_border_when_single=0
         border_radius=2
#       no_radius_when_single=0
         focused_opacity=1.0
         unfocused_opacity=1.0

#       Gaps
         gappih=5
         gappiv=5
         gappoh=5
         gappov=5

#         Change gaps
           bind=ALT+SHIFT,X,incgaps,1
           bind=ALT+SHIFT,Z,incgaps,-1
           bind=ALT+SHIFT,R,togglegaps

#       Overview
         hotarea_size=10
         enable_hotarea=0
         ov_tab_mode=0
         overviewgappi=5
         overviewgappo=30

#       Scratchpad
         scratchpad_width_ratio=0.8
         scratchpad_height_ratio=0.9
         scratchpadcolor=0x516c93ff

#       Misc
         globalcolor=0xb153a7ff
         overlaycolor=0x14a57cff
         cursor_size=24
         cursor_theme=macOS-White

#     Blur
       blur=1
       blur_layer=1
       blur_optimized=0
       blur_params_num_passes=2
       blur_params_radius=5
       blur_params_noise=0.02
       blur_params_brightness=0.9
       blur_params_contrast=0.9
       blur_params_saturation=1.2

#     Shadows
       shadows=1
       shadow_only_floating=0
       shadows_size=10
       shadows_blur=15
       shadows_position_x=0
       shadows_position_y=0
       shadowscolor=0x000010ff

#     Animations
       animations=1
       layer_animations=1
       animation_type_open=slide
       animation_type_close=slide
       animation_fade_in=1
       animation_fade_out=1
       tag_animation_direction=1
       zoom_initial_ratio=0.3
       zoom_end_ratio=0.8
       fadein_begin_opacity=0.5
       fadeout_begin_opacity=0.8
       animation_duration_move=400
       animation_duration_open=300
       animation_duration_tag=350
       animation_duration_close=200
       animation_duration_focus=0
       animation_curve_open=0.46,1.0,0.29,1
       animation_curve_move=0.46,1.0,0.29,1
       animation_curve_tag=0.46,1.0,0.29,1
       animation_curve_close=0.08,0.92,0,1
       animation_curve_focus=0.46,1.0,0.29,1
       animation_curve_opafadeout=0.5,0.5,0.5,0.5
       animation_curve_opafadein=0.46,1.0,0.29,1
     '';

     # peripherics.conf
     ".config/mango/peripherics.conf".text = ''
#     Nvidia
       syncobj_enable=1

#     Keyboard
       repeat_rate=25
       repeat_delay=600
       numlockon=0
       xkb_rules_layout=it

#     Trackpad
       disable_trackpad=0
       tap_to_click=1
       tap_and_drag=1
       drag_lock=1
       trackpad_natural_scrolling=1
       disable_while_typing=1
       left_handed=0
       middle_button_emulation=0
       swipe_min_threshold=1

#     Mouse
       mouse_natural_scrolling=0
       axis_bind_apply_timeout=100
       enable_hotarea=0

#     Screen lid
       switchbind=fold,spawn_shell,noctalia msg session lock-and-suspend

#     Gestures

#       Mouse
         mousebind=SUPER,btn_left,moveresize,curmove
         mousebind=SUPER,btn_right,moveresize,curresize
         mousebind=SUPER,btn_middle,togglefullscreen,0
         mousebind=ALT,btn_middle,togglemaximizescreen

#       Mouse Wheel
         axisbind=SUPER,UP,viewtoleft_have_client
         axisbind=SUPER,DOWN,viewtoright_have_client

#       Trackpad
         gesturebind=none,horizontal,3,tagscrub,have_client
         gesturebind=none,up,3,togglejump

         gesture_commit_ratio=0.3
         gesture_swipe_distance=800
     '';

     # env.conf
     ".config/mango/env.conf".text = ''
       env=XDG_CURRENT_DESKTOP,mango
       env=XDG_SESSION_DESKTOP,mango
       env=XDG_CURRENT_SESSION_TYPE,wayland
       env=XDG_DESKTOP_PORTAL,mango
       env=QT_QPA_PLATFORMTHEME,qt6ct
     '';

     # layouts.conf
     ".config/mango/layouts.conf".text = ''
#     Master-Stack layout
       new_is_master=1
       default_mfact=0.55
       default_nmaster=1
       smartgaps=0

#     Scroller layout
       scroller_structs=20
       scroller_default_proportion=0.8
       scroller_focus_center=0
       scroller_prefer_center=0
       edge_scroller_pointer_focus=1
       scroller_default_proportion_single=1.0
       scroller_proportion_preset=0.5,0.8,1.0

#     Switch layout
       bind=SUPER,n,switch_layout

#     Persistent Layouts
       tagrule=id:1,layout_name:tile
       tagrule=id:2,layout_name:tile
       tagrule=id:3,layout_name:tile
       tagrule=id:4,layout_name:tile
       tagrule=id:5,layout_name:tile
       tagrule=id:6,layout_name:tile
       tagrule=id:7,layout_name:tile
       tagrule=id:8,layout_name:tile
       tagrule=id:9,layout_name:tile
     '';

     ### Shell Scripts

     # Mango TUI
     "Scripts/mangosettings" = {
       executable = true;
       text = ''
         #!/bin/sh
         options=("(C)onfigure" "(R)ules" "(A)utostart" "(S)cratchpad" "(L)ook" "(M)ouse/Touchpad" "(E)nv" "(T)iling")

         printf "\n\n\n"
         printf "\033[38;2;174;198;255m%s\033[0m%s\033[38;2;255;186;30m%s\033[0m%s" \
         "               󱄅 " "<<" "Mango " "Settings!>> " "󱄅"
         printf "\n\n\n"

         if [ -n "$TERM" ] && [ -n "$EDITOR" ]; then
             if [ -n "$HJEM_FILE" ] && [ -f "$HJEM_FILE" ]; then
                 break
             else
                 printf "\n\n\n\n\n"
                 printf "\033[0m%s \033[38;2;174;198;255m%s " \
                 "     Make sure you've set" "\$HJEM_FILE" "correctly!"
                 printf "\n\n \033[38;2;89;92;99m%s \e[?25l" \
                 "             (Press any key to exit)"
                 read -rsn 1 key

                 case $key in
                 *|"")
                     pkill -f manset
                     ;;
                 esac
             fi
         else
             printf "\n\n\n"
             printf "\033[0m%s \033[38;2;174;198;255m%s " \
             "        Make sure you've set" "\$TERM" "and" "\$EDITOR" "!"

             printf "\n\n\033[38;2;89;92;99m%s" \
             "            (Works best with Foot and Kitty!)"
             printf "\n\n\n\n \033[38;2;89;92;99m%s \e[?25l" \
             "               (Press any key to exit)"
             read -rsn 1 key

             case $key in
                 *|"")
                     pkill -f manset
                     ;;
             esac
         fi

         for i in "''${!options[@]}"; do
             printf "\033[0m%s\033[38;2;255;186;30m%s\033[0m%s \n" \
             "      " "''${options[i]:0:3}" "''${options[i]:3}"
         done
         printf "\n\033[0m%s\033[38;2;89;92;99m%s\e[?25l" \
         "      Please select an option! " "(Esc) ([B]ack)"

         while true; do
             read -rsn 1 opt
             printf "\n"

             case $opt in
                 "c")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# config.conf" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "r")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# rules.conf" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "s")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 " Scratchpads" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "a")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# autostart.sh" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "l")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# appearance.conf" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "m")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# peripherics.conf" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "e")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# env.conf" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "t")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# layouts.conf" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     mmsg dispatch reload_config && mangowarn
                     pkill -f manset
                     ;;
                 "b")
                     mmsg dispatch minimized
                     $TERM --app-id nix-up sysettings
                     pkill -f manset
                     ;;
                 $'\e'|"")
                     pkill -f manset
                     ;;
                 *)
                     printf "\033[0m%s" "      Invalid option. Try again."
                     ;;
             esac
         done
       '';
     };

     # System TUI
     "Scripts/sysettings" = {
       executable = true;
       text = ''
	 #!/bin/sh
         options=("(U)pdate" "(C)onfigure" "(F)lake" "(H)jem" "(M)ango" "(G)arbage Collection" "(S)hell" "(T)UI Settings")

         printf "\n\n\n"
         printf "\033[38;2;174;198;255m%s\033[0m%s\033[38;2;174;198;255m%s\033[0m%s" \
         "               󱄅 " "<<" "System " "Settings!>> " "󱄅"
         printf "\n\n\n"

         if [ -n "$TERM" ] && [ -n "$EDITOR" ] && [ -n "$SHELL" ]; then
             break
         else
             printf "\n\n\n"
             printf "\033[0m%s\033[38;2;174;198;255m%s" \
             "      Make sure you've set " "\$TERM" ", " "\$SHELL " "and " "\$EDITOR" "!"

             printf "\n\n\033[38;2;89;92;99m%s" \
             "            (Works best with Foot and Kitty!)"
             printf "\n\n\n\n \033[38;2;89;92;99m%s \e[?25l" \
             "               (Press any key to exit)"
             read -rsn 1 key

             case $key in
                 *|"")
                     pkill -f nix-up
                     ;;
             esac
         fi

         cd /etc/nixos

         for i in "''${!options[@]}"; do
             printf "\033[0m%s\033[38;2;174;198;255m%s\033[0m%s \n" \
             "      " "''${options[i]:0:3}" "''${options[i]:3}"
         done
         printf "\n\033[0m%s\033[38;2;89;92;99m%s\e[?25l" \
         "      Please select an option! " "(Esc)"

         while true; do
             read -rsn 1 opt
             printf "\n"

             case $opt in
                 "u")
                     mmsg dispatch minimized
                     $TERM sh -c 'nh os switch -u && \
                     sudo reboot'
                     ;;
                 "c")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR configuration.nix && sudo nixos-rebuild switch && sleep 0.5'
                     ;;
                 "f")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR flake.nix && sudo nixos-rebuild switch && sleep 0,5'
                     pkill -f nix-up
                     ;;
                 "h")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE && sudo nixos-rebuild switch && sleep 0,5'
                     pkill -f nix-up
                     ;;
                 "g")
                     mmsg dispatch minimized
                     $TERM sh -c 'sudo journalctl --vacuum-time=1d && sudo rm -rf /tmp/* && nh clean all --no-gcroots && nix-store --optimise'
                     pkill -f nix-up
                     ;;
                 "s")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR configuration.nix:$(grep -nFm1 "# Zsh" "configuration.nix" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     pkill -f nix-up
                     ;;
                 "t")
                     mmsg dispatch minimized
                     $TERM --app-id tuiset tuisettings
                     pkill -f nix-up
                     ;;
                 "m")
                     mmsg dispatch minimized
                     $TERM --app-id manset mangosettings
                     pkill -f nix-up
                     ;;
                 $'\e'|"")
                     pkill -f nix-up
                     ;;
                 *)
                     echo "Invalid option. Try again."
                     ;;
             esac
         done
       '';
     };

     # TUI Menu
     "Scripts/tuisettings" = {
       executable = true;
       text = ''
         #!/bin/sh
         options=("(M)ango TUI" "(S)ystem TUI" "(T)his TUI")

         printf "\n\n\n"
         printf "\033[38;2;174;198;255m%s\033[0m%s\033[38;2;174;198;255m%s\033[0m%s" \
         "               󱄅 " "<<" "System " "Settings!>> " "󱄅"
         printf "\n\n\n\n\n\n"

         if [ -n "$TERM" ] && [ -n "$EDITOR" ]; then
             if [ -n "$HJEM_FILE" ] && [ -f "$HJEM_FILE" ]; then
                 break
             else
                 printf "\n\n\n\n\n"
                 printf "\033[0m%s \033[38;2;174;198;255m%s " \
                 "     Make sure you've set" "\$HJEM_FILE" "correctly!"
                 printf "\n\n \033[38;2;89;92;99m%s \e[?25l" \
                 "             (Press any key to exit)"
                 read -rsn 1 key

                 case $key in
                 *|"")
                     pkill -f tuiset
                     ;;
                 esac
             fi
         else
             printf "\n\n\n"
             printf "\033[0m%s\033[38;2;174;198;255m%s" \
             "      Make sure you've set " "\$TERM " "and " "\$EDITOR" "!"

             printf "\n\n\033[38;2;89;92;99m%s" \
             "            (Works best with Foot and Kitty!)"
             printf "\n\n\n\n \033[38;2;89;92;99m%s \e[?25l" \
             "               (Press any key to exit)"
             read -rsn 1 key

             case $key in
                 *|"")
                     pkill -f tuiset
                     ;;
             esac
         fi

         cd $HOME/Scripts

         for i in "''${!options[@]}"; do
             printf "\033[0m%s\033[38;2;174;198;255m%s\033[0m%s \n" \
             "      " "''${options[i]:0:3}" "''${options[i]:3}"
         done
         printf "\n\033[0m%s\033[38;2;89;92;99m%s\e[?25l" \
         "      Please select an option! " "(Esc) ([B]ack)"

         while true; do
             read -rsn 1 opt
             printf "\n"

             case ''$opt in
                 "s")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# System TUI" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     pkill -f tuiset
                     ;;
                 "t")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# TUI Menu" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     pkill -f tuiset
                     ;;
                 "m")
                     mmsg dispatch minimized
                     $TERM sh -c '$EDITOR $HJEM_FILE:$(grep -nFm1 "# Mango TUI" "$HJEM_FILE" | cut -d: -f1) && \
                     sudo nixos-rebuild switch && sleep 0.5'
                     pkill -f tuiset
                     ;;
                 "b")
                     mmsg dispatch minimized
                     $TERM --app-id nix-up sysettings
                     pkill -f tuiset
                     ;;
                 $'\e'|"")
                     pkill -f tuiset
                     ;;
                 *)
                     echo "Invalid option. Try again."
                     ;;
             esac
         done
       '';
     };

     # Other Scripts
     # Mango-related
     "Scripts/mangowarn" = {
       executable = true;
       text = ''
	 mango -p 2>&1 | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' | tr '\n' '\001' | xargs -I {} -r zsh -c 'notify-send --app-name=Mango --icon=$HOME/.config/mango/mango.png "You are a dumbass!!" "<i>$(echo "{}" | tr "\001" "\n")</i>"'
       '';
     };

     # Nixos-related
     "Scripts/syscleanup" = {
       executable = true;
       text = ''
         #!/bin/sh
	 journalctl --vacuum-time=1d && \
	 rm -rf /tmp/* && \
	 nh clean all --no-gcroots && \
	 nix-store --optimise
       '';
     };
    };
  };
}