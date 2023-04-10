#
# history - Zsh history configuration
#

() {
  local zopts=(
    # 16.2.4 History
    bang_hist               # Treat the '!' character specially during expansion.
    extended_history        # Write the history file in the ':start:elapsed;command' format.
    hist_expire_dups_first  # Expire a duplicate event first when trimming history.
    hist_find_no_dups       # Do not display a previously found event.
    hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
    hist_ignore_dups        # Do not record an event that was just recorded again.
    hist_ignore_space       # Do not record an event starting with a space.
    hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
    hist_save_no_dups       # Do not write a duplicate event to the history file.
    hist_verify             # Do not execute immediately upon history expansion.
    inc_append_history      # Write to the history file immediately, not when the shell exits.
    NO_hist_beep            # Don't beep when accessing non-existent history.
    NO_share_history        # Don't share history between all sessions.
  )
  setopt $zopts

  # $HISTFILE belongs in the data home, not with zsh configs
  HISTFILE=${XDG_DATA_HOME:=$HOME/.local/share}/zsh/history
  [[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

  # you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
  # (1000 and 2000 respectively), but if not we make them way bigger.
  [[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
  [[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000

  if ! zstyle -t ':zshzoo:history:alias' skip; then
    alias hist='fc -li'
    alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
  fi
}
