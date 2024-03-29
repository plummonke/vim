" Functions
function! Format(syntax)
    % left

    if a:syntax == "go"
        g/{$/ norm $ >i{
    elseif a:syntax == "js"
        g/{$/ norm $ >i{
    elseif a:syntax == "html"
        g/^<\w/ norm >it
        norm gg <G
    elseif a:syntax == "python"
        g/:$/ norm j >}
    elseif a:syntax == "css"
        g/{/ norm $ >i{
    else
        throw "No formatter"
        return 1
    endif

    norm gg
    return 0
endfunction

function! Prettify(syntax)
    if a:syntax == "css"
        % s/{/ {\r/g
        % s/;/;\r/g
        % s/}/\r}\r/g
        g/{/ norm O
    elseif a:syntax == "js"
        % s/{/{\r/g
        % s/;/;\r/g
        % s/}/\r}\r/g
        g/{/ norm O
    elseif a:syntax == "html"
        % s/>/>\r/g
    else
        throw "No prettifier"
        return 1
    endif

    return Format(a:syntax)
endfunction

function! Minify(syntax)
    g/^\s*$/ norm dd
    % left

    if a:syntax == "css"
        % s/:\s*/:
        % s/;\s*\n/;
        % s/\s*{\n/{
        % s/\n\?}\n/}
    elseif a:syntax == "js"
        % s/;\n/;
        % s/{\n/{
        % s/\n}/}
    elseif a:syntax == "html"
        % s/>\n/>
    else
        throw "No minifier"
        return 1
    endif
    return 0
endfunction

" Commands
com! Formatter call Format(b:current_syntax)
com! Prettify call Prettify(b:current_syntax)
com! Minify call Minify(b:current_syntax)

