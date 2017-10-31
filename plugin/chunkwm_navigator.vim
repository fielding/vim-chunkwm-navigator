if exists("g:loaded_chunkwm_navigator") || &cp
  finish
endif
let g:loaded_chunkwm_navigator = 1

set title

let s:chunkwm_window_last = 0
augroup chunkwm_navigator
  au!
  autocmd WinEnter * let s:chunkwm_window_last = 0
augroup END


function! s:UseChunkwmNavigatorMappings()
  return !get(g:, 'chunkwm_navigator_no_mappings', 0)
endfunction

function! s:SwitchWindow(key)
  let nr = winnr()
  let chunkwm_window_last = s:chunkwm_window_last

  if !chunkwm_window_last
    exec 'wincmd ' . a:key
  endif

  if chunkwm_window_last || nr == winnr()
      if a:key=='l'
        let cmd = 'chunkc tiling::window --focus east'
      elseif a:key=='k'
        let cmd = 'chunkc tiling::window --focus north'
      elseif a:key=='j'
        let cmd = 'chunkc tiling::window --focus south'
      elseif a:key=='h'
        let cmd = 'chunkc tiling::window --focus west'
      endif
      silent call system(cmd)
      let chunkwm_window_last = 1
  else
    let chunkwm_window_last = 0
  endif
endfunction

command! ChunkwmNavigateLeft call s:SwitchWindow('h')
command! ChunkwmNavigateDown call s:SwitchWindow('j')
command! ChunkwmNavigateUp call s:SwitchWindow('k')
command! ChunkwmNavigateRight call s:SwitchWindow('l')

if s:UseChunkwmNavigatorMappings()
  nnoremap <silent> <c-h> :ChunkwmNavigateLeft<cr>
  nnoremap <silent> <c-j> :ChunkwmNavigateDown<cr>
  nnoremap <silent> <c-k> :ChunkwmNavigateUp<cr>
  nnoremap <silent> <c-l> :ChunkwmNavigateRight<cr>
endif