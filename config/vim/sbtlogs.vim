function! ale_linters#scala#sbtlogs#Handle(buffer, lines) abort
  " Matches patterns line the following:
  "
  " [error] /path/to/file/Main.scala:30: Unmatched closing brace '}' ignored here
  let l:pattern = '^\[\(\w\+\)\]\s\+.\+:\(\d\+\):\s\+\(.\+\)$'
  let l:output = []

  for l:match in ale#util#GetMatches(a:lines, l:pattern)
    let l:type = l:match[1] ==# 'error' ? 'E' : 'W'
    let l:lnum = l:match[2]
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

function! ale_linters#scala#sbtlogs#GetCommand(buffer) abort
  let l:logPath = ale#path#ResolveLocalPath(
        \   a:buffer,
        \   'target/vim/compileissues.log',
        \   'compileissues.log'
        \)
  return 'cat ' . fnameescape(l:logPath)
endfunction

call ale#linter#Define('scala', {
      \   'name': 'sbtlogs',
      \   'executable': 'cat',
      \   'output_stream': 'stdout',
      \   'lint_file': 1,
      \   'command_callback': 'ale_linters#scala#sbtlogs#GetCommand',
      \   'callback': 'ale_linters#scala#sbtlogs#Handle',
      \})

