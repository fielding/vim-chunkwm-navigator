if exists("g:loaded_chunkwm_navigator") || &cp
  finish
endif
let g:loaded_chunkwm_navigator = 1

set title

function! s:UseChunkwmNavigatorMappings()
  return !get(g:, 'chunkwm_navigator_no_mappings', 0)
endfunction

function! s:SwitchWindow(key)
  let oldwindow = winnr()
  if a:key=='l'
    wincmd l
  elseif a:key=='k'
    wincmd k
  elseif a:key=='j'
    wincmd j
  elseif a:key=='h'
    wincmd h
  endif
  if oldwindow==winnr()
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