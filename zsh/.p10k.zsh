# Monochrome Powerlevel10k config (based on Pure)
# Modified by Braeden – 2025-10-16
# Keeps Pure-style behavior with clean black/white/grey look.

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # ───────────────────────────────
  # Monochrome palette
  # ───────────────────────────────
  local black='0'
  local dark_grey='240'
  local grey='244'
  local light_grey='250'
  local white='255'

  # ───────────────────────────────
  # Prompt layout
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir
    vcs
    newline
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    command_execution_time
    virtualenv
    context
    time
    newline
  )

  # ───────────────────────────────
  # Layout behavior
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # ───────────────────────────────
  # Prompt character
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$white
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$light_grey
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

  # ───────────────────────────────
  # Python virtualenv
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$dark_grey
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

  # ───────────────────────────────
  # Directory
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$light_grey

  # ───────────────────────────────
  # Context (user@host)
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%f%F{$grey}@%m%f"
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

  # ───────────────────────────────
  # Command execution time
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$dark_grey

  # ───────────────────────────────
  # Git (VCS) — show only inside repos
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_VCS_FOREGROUND=$grey

  # Only show Git info inside repos; hide completely elsewhere
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

  # No icons or extra symbols — just branch name
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON=
  typeset -g POWERLEVEL9K_VCS_DIRTY_ICON=
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=

  # Disable stale or async indicators
  typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=
  typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

  # Simplify content — just show branch name
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${P9K_CONTENT//[()]/}'

  # Remove any leading/trailing delimiters
  typeset -g POWERLEVEL9K_VCS_LEFT_DELIMITER=
  typeset -g POWERLEVEL9K_VCS_RIGHT_DELIMITER=


  # ───────────────────────────────
  # Time
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%I:%M:%S %p}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # ───────────────────────────────
  # Behavior options
  # ───────────────────────────────
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # ───────────────────────────────
  # Reload if already loaded
  # ───────────────────────────────
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file to overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
