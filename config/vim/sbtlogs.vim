function! ale_linters#scala#sbtlogs#Handle(buffer, lines) abort
source ~/dotfiles/config/vim/scala-ale-sbt.vim
    " Matches patterns line the following:
    "
    " stdin:19: F: Pipe chain should start with a raw value.
    let l:pattern = '\v^\[\w\+] $'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        let l:lnum = 0

        if l:match[1] !=# ''
            let l:lnum = l:match[1] + 0
        endif

        let l:type = l:match[1] ==# 'error' ? 'E' : 'W'
        let l:text = l:match[3]

        call add(l:output, {
        \   'lnum': l:lnum,
        \   'col': 0,
        \   'type': l:type,
        \   'text': l:text,
        \   'nr': l:match[2],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('scala', {
\   'name': 'sbtlogs',
\   'executable': 'cat',
\   'output_stream': 'stderr',
\   'command': 'cat target/vim/compileissues.log',
\   'callback': 'ale_linters#scala#sbtlogs#Handle',
\})
