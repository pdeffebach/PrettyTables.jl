# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
#
#   Function to include a table in a file.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

export include_pt_in_file

"""
    function include_pt_in_file(filename::AbstractString, mark::AbstractString, args...; kwargs...)

Include a table in the file `filename` using the mark `mark`.

This function will print a table using the arguments `args` and keywords
`kwargs` in the function `pretty_table` (**the IO must not be passed to `args`
here**). Then, it will search inside the file `filename` for the following
section:

    <PrettyTables mark>
    ...
    </PrettyTables>

and will **replace everything between the marks** with the printed table. If the
closing tag is in a separate line, then all characters before it will be kept.
This is important to add comment tags.

"""
function include_pt_in_file(filename::AbstractString, mark::AbstractString,
                            args...; kwargs...)

    orig = read(filename, String)

    # First, print the a string.
    io = IOBuffer()
    pretty_table(io, args...; kwargs...)
    str = String(take!(io))

    open(filename, "w") do f
        r = Regex("(?<=<PrettyTables $mark>)(?:.|\n)*?(?=.*</PrettyTables>)")
        s = SubstitutionString("\n$str")
        write(f, replace(orig, r => s))
    end

    return nothing
end