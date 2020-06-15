# make the brew-provided ruby the default
set -gx PATH /usr/local/opt/ruby/bin $PATH

set -g theme_newline_prompt '$ '
set -g theme_newline_cursor yes
function fish_right_prompt; end  # diable the right (timestamp) prompt
set -g theme_display_virtualenv no  # leaves the activate-provided prompt
