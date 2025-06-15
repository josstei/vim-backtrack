if exists('g:backtrack_loaded') | finish | endif

let g:backtrack_loaded= 1

command! Backtrack call backtrack#Execute()

