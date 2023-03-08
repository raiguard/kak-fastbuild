# https://www.fastbuild.org

hook global BufCreate .*[.](bff) %{
    set-option buffer filetype fastbuild
}

hook global WinSetOption filetype=fastbuild %{
    require-module fastbuild
}

provide-module fastbuild %{
    add-highlighter shared/fastbuild regions
    add-highlighter shared/fastbuild/code default-region group
    add-highlighter shared/fastbuild/comment region '(//|;)' $ fill comment
    add-highlighter shared/fastbuild/single_string region "'" "(?<!\\)(?:\\\\)*'" fill string
    add-highlighter shared/fastbuild/double_string region '"' '(?<!\\)(?:\\\\)*"' fill string

    add-highlighter shared/fastbuild/code/constant regex "\b[A-Z_]*\b" 0:value
    add-highlighter shared/fastbuild/code/directive regex "#(define|elif|else|endif|if|import|include|once)\b" 0:keyword
    add-highlighter shared/fastbuild/code/function_call regex "\b(\w*)\b\s*\(" 1:function
    add-highlighter shared/fastbuild/code/operator regex "(!=|-|=|\+)" 0:operator
    add-highlighter shared/fastbuild/code/variable regex "\.(\w*)\b" 0:variable

    add-highlighter shared/fastbuild/code/builtin regex "\b(_CURRENT_BFF_DIR_|_FASTBUILD_VERSION_STRING_|_FASTBUILD_VERSION_|_FASTBUILD_EXE_PATH_|_WORKING_DIR_|Alias|Compiler|Copy|CopyDir|CSAssembly|DLL|Error|Exec|Executable|ForEach|If|Library|ListDependencies|ObjectList|Print|RemoveDir|Settings|Test|TextFile|Unity|Using|VCXProject|VSProjectExternal|VSSolution|XCodeProject|exists|file_exists)\b" 0:builtin
}

hook -group fastbuild-highlight global WinSetOption filetype=fastbuild %{
    add-highlighter window/fastbuild ref fastbuild
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/fastbuild }
}
