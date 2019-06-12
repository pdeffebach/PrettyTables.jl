var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#PrettyTables.jl-1",
    "page": "Home",
    "title": "PrettyTables.jl",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendThis package has the purpose to print data in matrices in a human-readable format. It was inspired in the functionality provided by ASCII Table Generator.(Image: )"
},

{
    "location": "#Requirements-1",
    "page": "Home",
    "title": "Requirements",
    "category": "section",
    "text": "Julia >= 1.0\nParameters >= 0.10.3\nTables >= 0.1.14"
},

{
    "location": "#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "julia> using Pkg\njulia> Pkg.add(\"PrettyTables\")"
},

{
    "location": "#Manual-outline-1",
    "page": "Home",
    "title": "Manual outline",
    "category": "section",
    "text": "Pages = [\n    \"man/usage.md\"\n    \"man/formats.md\"\n    \"man/alignment.md\"\n    \"man/formatter.md\"\n    \"man/highlighters.md\"\n    \"man/examples.md\"\n]\nDepth = 2"
},

{
    "location": "#Library-documentation-1",
    "page": "Home",
    "title": "Library documentation",
    "category": "section",
    "text": "Pages = [\"lib/library.md\"]"
},

{
    "location": "man/usage/#",
    "page": "Usage",
    "title": "Usage",
    "category": "page",
    "text": ""
},

{
    "location": "man/usage/#Usage-1",
    "page": "Usage",
    "title": "Usage",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendThe following functions can be used to print data.function pretty_table([io::IO,] data::AbstractVecOrMat{T1}, header::AbstractVecOrMat{T2}, tf::PrettyTableFormat = unicode; kwargs...) where {T1,T2}Print to io the vector or matrix data with header header using the format tf (see Formats). If io is omitted, then it defaults to stdout. If header is empty, then it will be automatically filled with \"Col. i\" for the i-th column.The header can be a Vector or a Matrix. If it is a Matrix, then each row will be a header line. The first line is called header and the others are called sub-headers .julia> data = [1 2 3; 4 5 6];\n\njulia> pretty_table(data, [\"Column 1\", \"Column 2\", \"Column 3\"])\n┌──────────┬──────────┬──────────┐\n│ Column 1 │ Column 2 │ Column 3 │\n├──────────┼──────────┼──────────┤\n│        1 │        2 │        3 │\n│        4 │        5 │        6 │\n└──────────┴──────────┴──────────┘\n\njulia> pretty_table(data, [\"Column 1\" \"Column 2\" \"Column 3\"; \"A\" \"B\" \"C\"])\n┌──────────┬──────────┬──────────┐\n│ Column 1 │ Column 2 │ Column 3 │\n│        A │        B │        C │\n├──────────┼──────────┼──────────┤\n│        1 │        2 │        3 │\n│        4 │        5 │        6 │\n└──────────┴──────────┴──────────┘function pretty_table([io,] data::AbstractVecOrMat{T}, tf::PrettyTableFormat = unicode; ...) where TPrint to io the vector or matrix data using the format tf (see PrettyTableFormat). If io is omitted, then it defaults to stdout. The header will be automatically filled with \"Col. i\" for the i-th column.julia> data = Any[1 2 3; true false true];\n\njulia> pretty_table(data)\n┌────────┬────────┬────────┐\n│ Col. 1 │ Col. 2 │ Col. 3 │\n├────────┼────────┼────────┤\n│      1 │      2 │      3 │\n│   true │  false │   true │\n└────────┴────────┴────────┘note: Note\nIf data is a vector, then the header must be a vector. In this case, the first element is considered the header and the others are the sub-headers.function pretty_table([io::IO,] dict::Dict{K,V}, tf::PrettyTableFormat = unicode; sortkeys = true, ...) where {K,V}Print to io the dictionary dict in a matrix form (one column for the keys and other for the values), using the format tf (see PrettyTableFormat). If io is omitted, then it defaults to stdout.In this case, the keyword sortkeys can be used to select whether or not the user wants to print the dictionary with the keys sorted. If it is false, then the elements will be printed on the same order returned by the functions keys and values. Notice that this assumes that the keys are sortable, if they are not, then an error will be thrown.julia> dict = Dict(1 => \"Jan\", 2 => \"Feb\", 3 => \"Mar\", 4 => \"Apr\", 5 => \"May\", 6 => \"Jun\");\n\njulia> pretty_table(dict)\n┌───────┬────────┐\n│  Keys │ Values │\n│ Int64 │ String │\n├───────┼────────┤\n│     4 │    Apr │\n│     2 │    Feb │\n│     3 │    Mar │\n│     5 │    May │\n│     6 │    Jun │\n│     1 │    Jan │\n└───────┴────────┘\n\njulia> pretty_table(dict, sortkeys = true)\n┌───────┬────────┐\n│  Keys │ Values │\n│ Int64 │ String │\n├───────┼────────┤\n│     1 │    Jan │\n│     2 │    Feb │\n│     3 │    Mar │\n│     4 │    Apr │\n│     5 │    May │\n│     6 │    Jun │\n└───────┴────────┘\nfunction pretty_table([io,] table, tf::PrettyTableFormat = unicode; ...)Print to io the table table using the format tf (see Formats).  In this case, table must comply with the API of Tables.jl. If io is omitted, then it defaults to stdout.In all cases, the following keywords are available:border_crayon: Crayon to print the border.\nheader_crayon: Crayon to print the header.\nsubheaders_crayon: Crayon to print sub-headers.\nrownum_header_crayon: Crayon for the header of the column with the row                         numbers.\ntext_crayon: Crayon to print default text.\nalignment: Select the alignment of the columns (see the section              Alignment).\ncrop: Select the printing behavior when the data is bigger than the         available screen size (see screen_size). It can be :both to crop         on vertical and horizontal direction, :horizontal to crop only on         horizontal direction, :vertical to crop only on vertical direction,         or :none to do not crop the data at all.\nfilters_row: Filters for the rows (see the section Filters).\nfilters_col: Filters for the columns (see the section Filters).\nformatter: See the section Formatter.\nhighlighters: A tuple with a list of highlighters (see the section                 Highlighters).\nhlines: A vector of Int indicating row numbers in which an additional           horizontal line should be drawn after the row. Notice that numbers           lower than 1 and equal or higher than the number of rows will be           neglected.\nlinebreaks: If true, then \\n will break the line inside the cells.               (Default = false)\nnoheader: If true, then the header will not be printed. Notice that all             keywords and parameters related to the header and sub-headers will             be ignored. (Default = false)\nsame_column_size: If true, then all the columns will have the same size.                     (Default = false)\nscreen_size: A tuple of two integers that defines the screen size (num. of                rows, num. of columns) that is available to print the table. It                is used to crop the data depending on the value of the keyword                crop. If it is nothing, then the size will be obtained                automatically. Notice that if a dimension is not positive, then                it will be treated as unlimited. (Default = nothing)\nshow_row_number: If true, then a new column will be printed showing the                    row number. (Default = false)The keywords header_crayon and subheaders_crayon can be a Crayon or a Vector{Crayon}. In the first case, the Crayon will be applied to all the elements. In the second, each element can have its own crayon, but the length of the vector must be equal to the number of columns in the data."
},

{
    "location": "man/usage/#Crayons-1",
    "page": "Usage",
    "title": "Crayons",
    "category": "section",
    "text": "A Crayon is an object that handles a style for text printed on terminals. It is defined in the package Crayons.jl. There are many options available to customize the style, such as foreground color, background color, bold text, etc.A Crayon can be created in two different ways:julia> Crayon(foreground = :blue, background = :black, bold = :true)\n\njulia> crayon\"blue bg:black bold\"For more information, see the Crayon.jl documentation.info: Info\nThe Crayon.jl package is re-exported by PrettyTables.jl. Hence, you do not need using Crayons to create a Crayon."
},

{
    "location": "man/usage/#Cropping-1",
    "page": "Usage",
    "title": "Cropping",
    "category": "section",
    "text": "By default, the data will be cropped to fit the screen. This behavior can be changed by using the keyword crop.julia> data = Any[1    false      1.0     0x01 ;\n                  2     true      2.0     0x02 ;\n                  3    false      3.0     0x03 ;\n                  4     true      4.0     0x04 ;\n                  5    false      5.0     0x05 ;\n                  6     true      6.0     0x06 ;];\n\njulia> pretty_table(data, screen_size = (10,30))\n┌────────┬────────┬────────┬ ⋯\n│ Col. 1 │ Col. 2 │ Col. 3 │ ⋯\n├────────┼────────┼────────┼ ⋯\n│      1 │  false │    1.0 │ ⋯\n│      2 │   true │    2.0 │ ⋯\n│   ⋮    │   ⋮    │   ⋮    │ ⋯\n└────────┴────────┴────────┴ ⋯\n\njulia> pretty_table(data, screen_size = (10,30), crop = :none)\n┌────────┬────────┬────────┬────────┐\n│ Col. 1 │ Col. 2 │ Col. 3 │ Col. 4 │\n├────────┼────────┼────────┼────────┤\n│      1 │  false │    1.0 │      1 │\n│      2 │   true │    2.0 │      2 │\n│      3 │  false │    3.0 │      3 │\n│      4 │   true │    4.0 │      4 │\n│      5 │  false │    5.0 │      5 │\n│      6 │   true │    6.0 │      6 │\n└────────┴────────┴────────┴────────┘If the keyword screen_size is not specified (or is nothing), then the screen size will be obtained automatically. For files, screen_size = (-1,-1), meaning that no limit exits in both vertical and horizontal direction.note: Note\nIn vertical cropping, the header and the first table row is always printed.    note: Note\nThe highlighters will work even in partially printed data."
},

{
    "location": "man/usage/#Helpers-1",
    "page": "Usage",
    "title": "Helpers",
    "category": "section",
    "text": "The macro @pt was created to make it easier to pretty print tables to stdout. Its signature is:macro pt(expr...)where the expression list expr must be:[<Set of configurations> table]*in which the set of configurations are expressions like key = value. The keys can be:header: Select a header for the table.\ntf: Select a table format.\nAny other possible keyword that can be used in the function pretty_table.Notice that multiple tables can be printed. Furthermore, the configurations persist for multiple printing except for the header. Hence, for example:@pt header = header1 highlighters = hl1 formatter = ft1 table1 highlighters = hl2 table2will print table1 using the header header1 and the configuration highlighters = hl1 formatter = ft1 and will print table2 without header and using highlighters = hl2 formatter = ft1.julia> data = [1 2 3; 4 5 6];\n\njulia> @pt data\n┌──────────┬──────────┬──────────┐\n│ Column 1 │ Column 2 │ Column 3 │\n├──────────┼──────────┼──────────┤\n│        1 │        2 │        3 │\n│        4 │        5 │        6 │\n└──────────┴──────────┴──────────┘\n\njulia> @pt header = [\"Column 1\", \"Column 2\", \"Column 3\"] data header = [\"Column 1\" \"Column 2\" \"Column 3\"; \"A\" \"B\" \"C\"] data\n┌──────────┬──────────┬──────────┐\n│ Column 1 │ Column 2 │ Column 3 │\n├──────────┼──────────┼──────────┤\n│        1 │        2 │        3 │\n│        4 │        5 │        6 │\n└──────────┴──────────┴──────────┘\n┌──────────┬──────────┬──────────┐\n│ Column 1 │ Column 2 │ Column 3 │\n│        A │        B │        C │\n├──────────┼──────────┼──────────┤\n│        1 │        2 │        3 │\n│        4 │        5 │        6 │\n└──────────┴──────────┴──────────┘info: Info\nWhen more than one table is passed to this macro, then multiple calls to pretty_table will occur. Hence, the cropping algorithm will behave exactly the same as printing the tables separately."
},

{
    "location": "man/alignment/#",
    "page": "Alignment",
    "title": "Alignment",
    "category": "page",
    "text": ""
},

{
    "location": "man/alignment/#Alignment-1",
    "page": "Alignment",
    "title": "Alignment",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendThe keyword alignment can be a Symbol or a vector of Symbol.If it is a symbol, we have the following behavior::l or :L: the text of all columns will be left-aligned;\n:c or :C: the text of all columns will be center-aligned;\n:r or :R: the text of all columns will be right-aligned;\nOtherwise it defaults to :r.If it is a vector, then it must have the same number of symbols as the number of columns in data. The i-th symbol in the vector specify the alignment of the i-th column using the same symbols as described previously.julia> data = Any[ f(a) for a = 0:30:90, f in (sind,cosd,tand)];\n\njulia> pretty_table(data; alignment=:l)\n┌────────────────────┬────────────────────┬────────────────────┐\n│ Col. 1             │ Col. 2             │ Col. 3             │\n├────────────────────┼────────────────────┼────────────────────┤\n│ 0.0                │ 1.0                │ 0.0                │\n│ 0.5                │ 0.8660254037844386 │ 0.5773502691896258 │\n│ 0.8660254037844386 │ 0.5                │ 1.7320508075688772 │\n│ 1.0                │ 0.0                │ Inf                │\n└────────────────────┴────────────────────┴────────────────────┘\n\njulia> pretty_table(data; alignment=[:l,:c,:r])\n┌────────────────────┬────────────────────┬────────────────────┐\n│ Col. 1             │       Col. 2       │             Col. 3 │\n├────────────────────┼────────────────────┼────────────────────┤\n│ 0.0                │        1.0         │                0.0 │\n│ 0.5                │ 0.8660254037844386 │ 0.5773502691896258 │\n│ 0.8660254037844386 │        0.5         │ 1.7320508075688772 │\n│ 1.0                │        0.0         │                Inf │\n└────────────────────┴────────────────────┴────────────────────┘"
},

{
    "location": "man/filters/#",
    "page": "Filters",
    "title": "Filters",
    "category": "page",
    "text": ""
},

{
    "location": "man/filters/#Filters-1",
    "page": "Filters",
    "title": "Filters",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendIt is possible to specify filters to filter the data that will be printed. There are two types of filters: the row filters, which are specified by the keyword filters_row, and the column filters, which are specified by the keyword filters_col.The filters are a tuple of functions that must have the following signature:f(data,i)::Boolin which data is a pointer to the matrix that is being printed and i is the i-th row in the case of the row filters or the i-th column in the case of column filters. If this function returns true for i, then the i-th row (in case of filters_row) or the i-th column (in case of filters_col) will be printed. Otherwise, it will be omitted.A set of filters can be passed inside of a tuple. Notice that, in this case, all filters for a specific row or column must be return true so that it can be printed, i.e the set of filters has an AND logic.If the keyword is set to nothing, which is the default, then no filtering will be applied to the row and/or column.note: Note\nThe filters do not change the row and column numbering for the others modifiers such as formatters and highlighters. Thus, for example, if only the 4-th row is printed, then it will also be referenced inside the formatters and highlighters as 4 instead of 1."
},

{
    "location": "man/filters/#Example-1",
    "page": "Filters",
    "title": "Example",
    "category": "section",
    "text": "Given a matrix data, let\'s suppose that is desired to print:only the 5-th and 6-th column; and\nonly the rows in which the 5-th and 6-th columns are positive.Then we can use one of the following approaches:f_c(data,i)  = i in (5,6)\nf_r1(data,i) = data[i,5] >= 0\nf_r2(data,i) = data[i,6] >= 0and set filters_col = (f_c,) and filters_row = (f_r1,f_r2), orf_c(data,i) = i in (5,6)\nf_r(data,i) = (data[i,5] >= 0) && (data[i,6] >= 0)and set filters_col = (f_c,) and filters_row = (f_c,)."
},

{
    "location": "man/formats/#",
    "page": "Formats",
    "title": "Formats",
    "category": "page",
    "text": ""
},

{
    "location": "man/formats/#Formats-1",
    "page": "Formats",
    "title": "Formats",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendThe following table formats are available:unicode (Default)┌────────┬────────┬────────┬────────┐\n│ Col. 1 │ Col. 2 │ Col. 3 │ Col. 4 │\n├────────┼────────┼────────┼────────┤\n│      1 │  false │    1.0 │      1 │\n│      2 │   true │    2.0 │      2 │\n│      3 │  false │    3.0 │      3 │\n└────────┴────────┴────────┴────────┘ascii_dots.....................................\n: Col. 1 : Col. 2 : Col. 3 : Col. 4 :\n:........:........:........:........:\n:      1 :  false :    1.0 :      1 :\n:      2 :   true :    2.0 :      2 :\n:      3 :  false :    3.0 :      3 :\n:........:........:........:........:ascii_rounded.--------.--------.--------.--------.\n| Col. 1 | Col. 2 | Col. 3 | Col. 4 |\n:--------+--------+--------+--------:\n|      1 |  false |    1.0 |      1 |\n|      2 |   true |    2.0 |      2 |\n|      3 |  false |    3.0 |      3 |\n\'--------\'--------\'--------\'--------\'borderless  Col. 1   Col. 2   Col. 3   Col. 4\n\n       1    false      1.0        1\n       2     true      2.0        2\n       3    false      3.0        3compact -------- -------- -------- --------\n  Col. 1   Col. 2   Col. 3   Col. 4\n -------- -------- -------- --------\n       1    false      1.0        1\n       2     true      2.0        2\n       3    false      3.0        3\n -------- -------- -------- --------markdown| Col. 1 | Col. 2 | Col. 3 | Col. 4 |\n|--------|--------|--------|--------|\n|      1 |  false |    1.0 |      1 |\n|      2 |   true |    2.0 |      2 |\n|      3 |  false |    3.0 |      3 |mysql+--------+--------+--------+--------+\n| Col. 1 | Col. 2 | Col. 3 | Col. 4 |\n+--------+--------+--------+--------+\n|      1 |  false |    1.0 |      1 |\n|      2 |   true |    2.0 |      2 |\n|      3 |  false |    3.0 |      3 |\n+--------+--------+--------+--------+simple========= ======== ======== =========\n  Col. 1   Col. 2   Col. 3   Col. 4\n========= ======== ======== =========\n       1    false      1.0        1\n       2     true      2.0        2\n       3    false      3.0        3\n========= ======== ======== =========unicode_rounded╭────────┬────────┬────────┬────────╮\n│ Col. 1 │ Col. 2 │ Col. 3 │ Col. 4 │\n├────────┼────────┼────────┼────────┤\n│      1 │  false │    1.0 │      1 │\n│      2 │   true │    2.0 │      2 │\n│      3 │  false │    3.0 │      3 │\n╰────────┴────────┴────────┴────────╯note: Note\nThe format unicode_rounded should look awful on your browser, but it should be printed fine on your terminal.julia> data = Any[ f(a) for a = 0:15:90, f in (sind,cosd,tand)];\n\njulia> pretty_table(data, ascii_dots)\n..................................................................\n:              Col. 1 :              Col. 2 :             Col. 3 :\n:.....................:.....................:....................:\n:                 0.0 :                 1.0 :                0.0 :\n: 0.25881904510252074 :  0.9659258262890683 : 0.2679491924311227 :\n:                 0.5 :  0.8660254037844386 : 0.5773502691896258 :\n:  0.7071067811865476 :  0.7071067811865476 :                1.0 :\n:  0.8660254037844386 :                 0.5 : 1.7320508075688772 :\n:  0.9659258262890683 : 0.25881904510252074 : 3.7320508075688776 :\n:                 1.0 :                 0.0 :                Inf :\n:.....................:.....................:....................:\n\njulia> pretty_table(data, compact)\n --------------------- --------------------- --------------------\n               Col. 1                Col. 2               Col. 3\n --------------------- --------------------- --------------------\n                  0.0                   1.0                  0.0\n  0.25881904510252074    0.9659258262890683   0.2679491924311227\n                  0.5    0.8660254037844386   0.5773502691896258\n   0.7071067811865476    0.7071067811865476                  1.0\n   0.8660254037844386                   0.5   1.7320508075688772\n   0.9659258262890683   0.25881904510252074   3.7320508075688776\n                  1.0                   0.0                  Inf\n --------------------- --------------------- --------------------\nIt is also possible to define you own custom table by creating a new instance of the structure PrettyTableFormat. For example, let\'s say that you want a table like simple that does not print the bottom line:julia> data = Any[ f(a) for a = 0:15:90, f in (sind,cosd,tand)];\n\njulia> tf = PrettyTableFormat(simple, bottom_line = false);\n\njulia> pretty_table(data, tf)\n====================== ===================== =====================\n               Col. 1                Col. 2               Col. 3\n====================== ===================== =====================\n                  0.0                   1.0                  0.0\n  0.25881904510252074    0.9659258262890683   0.2679491924311227\n                  0.5    0.8660254037844386   0.5773502691896258\n   0.7071067811865476    0.7071067811865476                  1.0\n   0.8660254037844386                   0.5   1.7320508075688772\n   0.9659258262890683   0.25881904510252074   3.7320508075688776\n                  1.0                   0.0                  Inf\nFor more information, see the documentation of the structure PrettyTableFormat."
},

{
    "location": "man/formatter/#",
    "page": "Formatters",
    "title": "Formatters",
    "category": "page",
    "text": ""
},

{
    "location": "man/formatter/#Formatter-1",
    "page": "Formatters",
    "title": "Formatter",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendThe keyword formatter can be used to pass functions to format the values in the columns. It must be a Dict{Number,Function}(). The key indicates the column number in which its elements will be converted by the function in the value of the dictionary. The function must have the following signature:f(value, i)in which value is the data and i is the row number. It must return the formatted value.For example, if we want to multiply all values in odd rows of the column 2 by π, then the formatter should look like:Dict(2 => (v,i)->isodd(i) ? v*π : v)If the key 0 is present, then the corresponding function will be applied to all columns that does not have a specific key.julia> data = Any[ f(a) for a = 0:30:90, f in (sind,cosd,tand)];\n\njulia> formatter = Dict(0 => (v,i) -> round(v,digits=3));\n\njulia> pretty_table(data; formatter=formatter)\n┌────────┬────────┬────────┐\n│ Col. 1 │ Col. 2 │ Col. 3 │\n├────────┼────────┼────────┤\n│    0.0 │    1.0 │    0.0 │\n│    0.5 │  0.866 │  0.577 │\n│  0.866 │    0.5 │  1.732 │\n│    1.0 │    0.0 │    Inf │\n└────────┴────────┴────────┘There are a set of pre-defined formatters (with names ft_*) to make the usage simpler. They are defined in the file ./src/predefined_formatter.jl.function ft_printf(ftv_str, [columns])Apply the formats ftv_str (see @sprintf) to the elements in the columns columns.If ftv_str is a Vector, then columns must be also be a Vector with the same number of elements. If ftv_str is a String, and columns is not specified (or is empty), then the format will be applied to the entire table. Otherwise, if ftv_str is a String and columns is a Vector, then the format will be applied only to the columns in columns.julia> data = Any[ f(a) for a = 0:30:90, f in (sind,cosd,tand)];\n\njulia> pretty_table(data; formatter=ft_printf(\"%5.3f\"))\n┌────────┬────────┬────────┐\n│ Col. 1 │ Col. 2 │ Col. 3 │\n├────────┼────────┼────────┤\n│  0.000 │  1.000 │  0.000 │\n│  0.500 │  0.866 │  0.577 │\n│  0.866 │  0.500 │  1.732 │\n│  1.000 │  0.000 │    Inf │\n└────────┴────────┴────────┘\n\njulia> pretty_table(data; formatter=ft_printf(\"%5.3f\", [1,3]))\n┌────────┬────────────────────┬────────┐\n│ Col. 1 │             Col. 2 │ Col. 3 │\n├────────┼────────────────────┼────────┤\n│  0.000 │                1.0 │  0.000 │\n│  0.500 │ 0.8660254037844386 │  0.577 │\n│  0.866 │                0.5 │  1.732 │\n│  1.000 │                0.0 │    Inf │\n└────────┴────────────────────┴────────┘note: Note\nNow, this formatter uses the function sprintf1 from the package Formatting.jl that drastically improved the performance compared to the case with the macro @sprintf. Thanks to @RalphAS for the information!function ft_round(digits, [columns])Round the elements in the columns columns to the number of digits in digits.If digits is a Vector, then columns must be also be a Vector with the same number of elements. If digits is a Number, and columns is not specified (or is empty), then the rounding will be applied to the entire table. Otherwise, if digits is a Number and columns is a Vector, then the elements in the columns columns will be rounded to the number of digits digits.julia> data = Any[ f(a) for a = 0:30:90, f in (sind,cosd,tand)];\n\njulia> pretty_table(data; formatter=ft_round(1))\n┌────────┬────────┬────────┐\n│ Col. 1 │ Col. 2 │ Col. 3 │\n├────────┼────────┼────────┤\n│    0.0 │    1.0 │    0.0 │\n│    0.5 │    0.9 │    0.6 │\n│    0.9 │    0.5 │    1.7 │\n│    1.0 │    0.0 │    Inf │\n└────────┴────────┴────────┘\n\njulia> pretty_table(data; formatter=ft_round(1,[1,3]))\n┌────────┬────────────────────┬────────┐\n│ Col. 1 │             Col. 2 │ Col. 3 │\n├────────┼────────────────────┼────────┤\n│    0.0 │                1.0 │    0.0 │\n│    0.5 │ 0.8660254037844386 │    0.6 │\n│    0.9 │                0.5 │    1.7 │\n│    1.0 │                0.0 │    Inf │\n└────────┴────────────────────┴────────┘"
},

{
    "location": "man/highlighters/#",
    "page": "Highlighters",
    "title": "Highlighters",
    "category": "page",
    "text": ""
},

{
    "location": "man/highlighters/#Highlighters-1",
    "page": "Highlighters",
    "title": "Highlighters",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendA highlighter is an instance of the structure Highlighter that contains information about which elements a highlight style should be applied. The structure contains three fields:f: Function with the signature f(data,i,j) in which should return true      if the element (i,j) in data must be highlighted, or false      otherwise.\ncrayon: Crayon with the style of a highlighted element.The function f must have the following signature:f(data, i, j)in which data is a reference to the data that is being printed, i and j are the element coordinates that are being tested. If this function returns true, then the highlight style will be applied to the (i,j) element. Otherwise, the default style will be used.A set of highlighters can be passed as a Tuple to the highlighter keyword. Notice that if multiple highlighters are valid for the element (i,j), then the applied style will be equal to the first match considering the order in the Tuple highlighters.(Image: )(Image: )note: Note\nIf the highlighters are used together with Formatter, then the change in the format will not affect that parameter data passed to the highlighter function f. It will always receive the original, unformatted value.There are a set of pre-defined highlighters (with names hl_*) to make the usage simpler. They are defined in the file ./src/predefined_highlighters.jl.To make the syntax less cumbersome, the following helper function is available:    function Highlighter(f; kwargs...)It creates a Highlighter with the function f and pass all the keyword arguments kwargs to the Crayon. Hence, the following code:julia> Highlighter((data,i,j)->isodd(i), Crayon(bold = true, background = :dark_gray))can be replaced by:julia> Highlighter((data,i,j)->isodd(i); bold = true, background = :dark_gray)"
},

{
    "location": "man/examples/#",
    "page": "Examples",
    "title": "Examples",
    "category": "page",
    "text": ""
},

{
    "location": "man/examples/#Examples-1",
    "page": "Examples",
    "title": "Examples",
    "category": "section",
    "text": "CurrentModule = PrettyTables\nDocTestSetup = quote\n    using PrettyTables\nendIn the following, it is presented how the following matrix can be printed using this package:julia> data = Any[ 1    false      1.0     0x01 ;\n                   2     true      2.0     0x02 ;\n                   3    false      3.0     0x03 ;\n                   4     true      4.0     0x04 ;\n                   5    false      5.0     0x05 ;\n                   6     true      6.0     0x06 ;](Image: )(Image: )(Image: )(Image: )(Image: )The following example indicates how highlighters can be used to highlight the lowest and highest element in the data considering the columns 1, 3, and 5:(Image: )Since this package has support to the API defined by Tables.jl, then many formats, e.g DataFrames.jl, can be pretty printed:(Image: )You can use hlines keyword to divide the table into interesting parts:(Image: )If you want to break lines inside the cells, then you can set the keyword linebreaks to true. Hence, the characters \\n will cause a line break inside the cell.(Image: )The keyword noheader can be used to suppres the header, which leads to a very simplistic, compact format.(Image: )In the following, it is shown how the filters can be used to print only the even rows and columns:(Image: )By default, if the data is larger than the screen, then it will be cropped to fit it. This can be changed by using the keywords crop and screen_size.(Image: )If you want to save the printed table to a file, you can do:julia> open(\"output.txt\", \"w\") do f\n            pretty_table(f,data)\n       end"
},

]}