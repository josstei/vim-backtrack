if exists('g:backtrack_loaded') | finish | endif

let g:backtrack_default_split   = 'split'
let g:backtrack_loaded          = 1

if !exists('g:backtrack_split')
    let g:backtrack_split = g:backtrack_default_split
endif

command! Backtrack call backtrack#Execute()

