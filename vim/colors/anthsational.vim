hi clear Normal
set bg&

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "anthsational"

" Git Diff colors
hi diffAdded    ctermfg=darkgreen
hi DiffRemoved  ctermfg=darkred
hi Special      ctermfg=darkmagenta
hi Type         ctermfg=yellow
hi PreProc      ctermfg=blue
