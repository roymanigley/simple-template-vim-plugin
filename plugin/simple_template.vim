set nocompatible
let g:menu_available_templates = [] 

function simple_template#show_templates(path)
    let g:menu_available_templates = [] 
    call add(g:menu_available_templates, "abort")
    for cmd in split(system('find ' . a:path . ' -type f 2>/dev/null | sort'), '\n')
        call add(g:menu_available_templates, cmd)
    endfor
    call popup_menu(g:menu_available_templates, #{ callback: 'simple_template#select_by_menu' , title: 'select a template'})
endfunction

function simple_template#select_by_menu(id, result)
    if (a:result == 1)
        return ""
    endif
    const path = g:menu_available_templates[a:result - 1]
    call simple_template#select(path)
endfunction

function simple_template#select(path)
    exec '-1read ' . a:path
    call simple_template#find_placeholders()
endfunction

function simple_template#find_placeholders()
    normal /$([A-Za-z0-9_]\+)
    normal gn
endfunction

