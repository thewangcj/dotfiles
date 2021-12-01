# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/wcj/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages colorize cp man command-not-found sudo ubuntu archlinux zsh-navigation-tools z extract history-substring-search autojump python zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## 输入法，ibus和fcitx
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export QT4_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

alias cls='clear'

## 安装trash-cli
## trash-cli 常用功能
## trash-put 将文件或目录移入回收站
## trash-empty 清空回收站
## trash-list 列出回收站中的文件
## trash-restore 还原回收站中的文件
## trash-rm 删除回首站中的单个文件
# alias rm='trash-put'
# alias rmclean='trash-empty'
# alias rmrest='trash-restore'
# alias rmlist='trash-list'
# alias rmrm='trash-rm'
alias gs='git status'
alias v="vim"
alias ll="ls -lh"
alias lla="ls -lah"

alias all_porxy="export ALL_PROXY="http://10.0.74.44:7890""
alias egph="git config --global http.proxy 'socks5://10.0.74.44:7890'"
alias egphs="git config --global https.proxy 'socks5://10.0.74.44:7890'"
alias dgp="git config --global --unset http.proxy&git config --global --unset https.proxy"

## 安装 zsh-syntax-highlighting 不同发行版安装位置不同修改路径
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## 安装 zsh-autosuggestions 不同发行版安装位置不同修改路径
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
## 修改提示字符颜色
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
export DESTDIR=/home/wcj/tools/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export RTE_SDK=/home/wcj/tools/dpdk

CMAKE_ROOT=/home/wcj/tools/cmake-3.20.5-linux-x86_64
export PATH=$PATH:$CMAKE_ROOT/bin/

[[ -s /home/wcj/.autojump/etc/profile.d/autojump.sh ]] && source /home/wcj/.autojump/etc/profile.d/autojump.sh

        autoload -U compinit && compinit -u

FD_ROOT=/home/wcj/tools/fd-v8.2.1-x86_64
export PATH=$PATH:$FD_ROOT/

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 启用ruby2.5
source /opt/rh/rh-ruby25/enable
