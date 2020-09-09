" fzf
function! FindGitRoot()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command], "dir": FindGitRoot()}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang PRg call RipgrepFzf(<q-args>, <bang>0)

if (exists(':CocList'))
  "command! -nargs=0 Format      :call CocAction('runCommand', 'eslint.executeAutofix')
  "command! -nargs=? Fold        :call CocAction('fold', <f-args>)
  "command! -nargs=0 OR          :call CocAction('runCommand', 'editor.action.organizeImport')
  "command! -nargs=0 JestInit    :call CocAction('runCommand', 'jest.init')
  "command! -nargs=0 Jest        :call CocAction('runCommand', 'jest.projectTest')
  "command! -nargs=0 JestCurrent :call CocAction('runCommand', 'jest.fileTest', ['%'])
  "command! -nargs=0 Prettier    :CocCommand prettier.formatFile
endif
