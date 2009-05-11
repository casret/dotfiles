#
# Generic .zshenv file for zsh 2.7
#
# $Revision: 1.2 $
# $Date: 1995/02/01 02:51:22 $
#
# .zshenv is sourced on all invocations of the
# shell, unless the -f option is set.  It should
# contain commands to set the command search path,
# plus other important environment variables.
# .zshenv should not contain commands that product
# output or assume the shell is attached to a tty.
#

#export X11HOME=/usr/X11R6
#export XKEYSYMDB=/usr/X11R6/lib/X11/XKeysymDB 
#path=($X11HOME/bin)
path=(/usr/local /usr/local/bin /opt/local/bin /opt/local/sbin /usr/bin /usr/etc /bin /sbin)
path=($path ~/bin /usr/sbin /opt/bin)
path=($path ~/.sprouts/cache/0.7/sprout-flex3sdk-tool-3.3.0/archive/bin)
#IRC shit
export IRCNAME=casret
export IRCNICK=casret
export IRCPATH=$HOME/.irc
export PGPPATH=~/.pgp
export REPLYTO=giao@brightroll.com

#ls colors
#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.class=01;32:*.c=01;33:*.h=01;33:*.tex=01;33:*.ps=01;35:*.dvi=01;35:*.java=01;33:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:';
eval `dircolors ~/.dircolors`

export NNTPSERVER=news.rcn.com

export MANPATH=$MANPATH:/usr/lib/perl5/man:/usr/local/ssl/man:/opt/local/share/man
export EDITOR=vim

# less
export LESS="-i-j1-w-R-F-X"


#EC2`
export EC2_HOME=~/ec2-api-tools-1.2-11797
PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=~/.ec2/pk-KCGAPIBNJAD3WVTNZJK2TMOVI2ADZP4X.pem
export EC2_CERT=~/.ec2/cert-KCGAPIBNJAD3WVTNZJK2TMOVI2ADZP4X.pem
# where to look for autoloaded function definitions
fpath=(~/.zfuns $fpath)
typeset -U fpath
