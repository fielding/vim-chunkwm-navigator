if exists("g:loaded_chunkwm_navigator") || &cp
  finish
endif
let g:loaded_chunkwm_navigator = 1

" Determine if this is really the way to handle this? 
" Other options are to detect window in a di
set title

let s:key_to_direction_map = {
      \ 'h': 'west',
      \ 'j': 'south',
      \ 'k': 'north',
      \ 'l': 'east'
\ }

if !exists('g:chunkwm_navigator_save_on_switch')
  let g:chunkwm_navigator_save_on_switch = 0
endif

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
    if g:chunkwm_navigator_save_on_switch == 1
      try
        update " save the active buffer. See :help update
      catch /^Vim\%((\a\+)\)\=:E32/ " catches the no file name error
      endtry
    elseif g:chunkwm_navigator_save_on_switch == 2
      try
        wall " save all the buffers. See :help wall
      catch /^Vim\%((\a\+)\)\=:E141/ " catches the no file name error
      endtry
    endif
    let cmd = 'chunkc tiling::window --focus ' . get(s:key_to_direction_map, a:key, '')
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