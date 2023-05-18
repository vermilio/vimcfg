vim9script noclear
#-
# init.vim - Initialize config.
#
# Created by Vamirio on 2021 Nov 08
#-

# Prevent reload.
if exists('loaded')
	finish
endif
var loaded = 1

# Get the directory where this file is located.
var home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

# Define a command to load the file.
command -nargs=1 LoadScript execute 'source ' .. home .. '/' .. '<args>'

# Add dir vimcfg to runtimepath.
execute 'set runtimepath+=' .. home

# Add dir ~/.vim or ~/vimfile to runtimepath (sometimes vim will not add it
# automatically for you).
if has('unix')
	set runtimepath+=~/.vim
elseif has('win32')
	set runtimepath+=~/vimfiles
endif

#-
# Load modules.
#-
# Load basic config.
LoadScript core/basic.vim

# Load extended config.
LoadScript core/extended.vim

# Load keymaps.
LoadScript core/keymaps.vim

# Load plugins config.
LoadScript core/plugins.vim

# Load UI style.
LoadScript core/ui.vim

# Load plugins keymaps.
LoadScript core/plugins_keymaps.vim

# Load vim-which-key map.
LoadScript core/which_key_map.vim
