## COLORSCHEME: gruvbox dark (medium)
# default statusbar color
set-option -g status-style bg=#3C3836,fg=#a89984 # bg=bg1, fg=fg4

# default window title colors
set-window-option -g window-status-style bg=#504945,fg=#EBDBB2 # bg=bg2, fg=fg1

# default window with an activity alert
set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

# active window title colors
set-window-option -g window-status-current-style bg=#FABD2F,fg=#282828 # bg=yellow, fg=bg0

# pane border
set-option -g pane-active-border-style fg=colour250 #fg2
set-option -g pane-border-style fg=colour237 #bg1

# message infos
#set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

# writing commands inactive
#set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

# pane number display
#set-option -g display-panes-active-colour colour250 #fg2
#set-option -g display-panes-colour colour237 #bg1

# clock
#set-window-option -g clock-mode-colour colour109 #blue

# bell
set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
set-option -g status-justify "centre"
set-option -g status-left-style none
set-option -g status-left-length "80"
set-option -g status-right-style none
set-option -g status-right-length "80"
set-window-option -g window-status-separator ""
#
set-option -g status-left "#[bg=#A89984,fg=#282828,bold] #S #[bg=colour237,fg=#A89984,nobold,noitalics,nounderscore]"
set-option -g status-right "#[fg=#A89984,nobold,noitalics,nounderscore]#[bg=#A89984,fg=#282828,bold] #h "

set-window-option -g window-status-current-format "#[bg=colour214,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour214,fg=#282828] #I #[bg=colour214,fg=#282828,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour214,nobold,noitalics,nounderscore]"
set-window-option -g window-status-format "#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=#EBDBB2] #I #[bg=colour239,fg=#EBDBB2] #W #[bg=colour237,fg=colour239,noitalics]"

