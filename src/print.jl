#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
#
#   Functions to print the tables.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#

export pretty_table

################################################################################
#                               Public Functions
################################################################################

"""
    pretty_table([io::IO | String,] table[, header::AbstractVecOrMat];  kwargs...)

Print to `io` the table `table` with header `header`. If `conf` is omitted, then
the default configuration will be used. If `io` is omitted, then it defaults to
`stdout`. If `String` is passed in the place of `io`, then a `String` with the
printed table will be returned by the function.

The `header` can be a `Vector` or a `Matrix`. If it is a `Matrix`, then each row
will be a header line. The first line is called *header* and the others are
called *sub-headers* . If `header` is empty or missing, then it will be
automatically filled with "Col.  i" for the *i*-th column.

When printing, it will be verified if `table` complies with **Tables.jl** API.
If it is compliant, then this interface will be used to print the table. If it
is not compliant, then only the following types are supported:

1. `AbstractVector`: any vector can be printed. In this case, the `header`
   **must** be a vector, where the first element is considered the header and
   the others are the sub-headers.
2. `AbstractMatrix`: any matrix can be printed.
3. `Dict`: any `Dict` can be printed. In this case, the special keyword
   `sortkeys` can be used to select whether or not the user wants to print the
   dictionary with the keys sorted. If it is `false`, then the elements will be
   printed on the same order returned by the functions `keys` and `values`.
   Notice that this assumes that the keys are sortable, if they are not, then an
   error will be thrown.

# Keywords

* `alignment`: Select the alignment of the columns (see the section `Alignment`).
* `backend`: Select which back-end will be used to print the table (see the
             section `Backend`). Notice that the additional configuration in
             `kwargs...` depends on the selected backend. (see the section
             `Backend`).
* `cell_alignment`: A tuple of functions with the signature `f(data,i,j)` that
                    overrides the alignment of the cell `(i,j)` to the value
                    returned by `f`. It can also be a single function, when it
                    is assumed that only one alignment function is required, or
                    `nothing`, when no cell alignment modification will be
                    performed. If the function `f` does not return a valid
                    alignment symbol as shown in section `Alignment`, then it
                    will be discarded. For convenience, it can also be a
                    dictionary of type `(i,j) => a` that overrides the
                    alignment of the cell `(i,j)` to `a`. `a` must be a symbol
                    like specified in the section `Alignment`.
  !!! note

      If more than one alignment function is passed to `cell_alignment`, then
      the functions will be evaluated in the same order of the tuple. The
      first one that returns a valid alignment symbol for each cell is applied,
      and the rest is discarded.

  (**Default** = `nothing`)
* `cell_first_line_only`: If `true`, then only the first line of each cell will
  be printed. (**Default** = `false`)
* `compact_printing`: Select if the option `:compact` will be used when printing
                      the data. (**Default** = `true`)
* `filters_row`: Filters for the rows (see the section `Filters`).
* `filters_col`: Filters for the columns (see the section `Filters`).
* `formatters`: See the section `Formatters`.
* `header_alignment`: Select the alignment of the header columns (see the
                      section `Alignment`). If the symbol that specifies the
                      alignment is `:s` for a specific column, then the same
                      alignment in the keyword `alignment` for that column will
                      be used. (**Default** = `:s`)
* `header_cell_alignment`: This keyword has the same structure of
                           `cell_alignment` but in this case it operates in the
                           header. Thus, `(i,j)` will be a cell in the header
                           matrix that contains the header and sub-headers. This
                           means that the `data` field in the functions will be
                           the same value passed in the keyword `header`.
  !!! note

      If more than one alignment function is passed to `header_cell_alignment`,
      then the functions will be evaluated in the same order of the tuple. The
      first one that returns a valid alignment symbol for each cell is applied,
      and the rest is discarded.

  (**Default** = `nothing`)
* `renderer`: A symbol that indicates which function should be used to convert
              an object to a string. It can be `:print` to use the function
              `print` or `:show` to use the function `show`. Notice that this
              selection is applicable only to the table data. Headers,
              sub-headers, and row name column are always rendered with print.
              (**Default** = `:print`)
* `row_names`: A vector containing the row names that will be appended to the
               left of the table. If it is `nothing`, then the column with the
               row names will not be shown. Notice that the size of this vector
               must match the number of rows in the table.
               (**Default** = `nothing`)
* `row_name_alignment`: Alignment of the column with the rows name (see the
                        section `Alignment`).
* `row_name_column_title`: Title of the column with the row names.
                           (**Default** = "")
* `title`: The title of the table. If it is empty, then no title will be
           printed. (**Default** = "")
* `title_alignment`: Alignment of the title, which must be a symbol as explained
                     in the section `Alignment`. This argument is ignored in the
                     LaTeX backend. (**Default** = :l)

!!! note

    Notice that all back-ends have the keyword `tf` to specify the table
    printing format. Thus, if the keyword `backend` is not present or if it is
    `nothing`, then the back-end will be automatically inferred from the type of
    the keyword `tf`. In this case, if `tf` is also not present, then it just
    fall-back to the text back-end.

# Alignment

The keyword `alignment` can be a `Symbol` or a vector of `Symbol`.

If it is a symbol, we have the following behavior:

* `:l` or `:L`: the text of all columns will be left-aligned;
* `:c` or `:C`: the text of all columns will be center-aligned;
* `:r` or `:R`: the text of all columns will be right-aligned;
* Otherwise it defaults to `:r`.

If it is a vector, then it must have the same number of symbols as the number of
columns in `data`. The *i*-th symbol in the vector specify the alignment of the
*i*-th column using the same symbols as described previously.

# Filters

It is possible to specify filters to filter the data that will be printed. There
are two types of filters: the row filters, which are specified by the keyword
`filters_row`, and the column filters, which are specified by the keyword
`filters_col`.

The filters are a tuple of functions that must have the following signature:

```julia
f(data,i)::Bool
```

in which `data` is a pointer to the matrix that is being printed and `i` is the
i-th row in the case of the row filters or the i-th column in the case of column
filters. If this function returns `true` for `i`, then the i-th row (in case of
`filters_row`) or the i-th column (in case of `filters_col`) will be printed.
Otherwise, it will be omitted.

A set of filters can be passed inside of a tuple. Notice that, in this case,
**all filters** for a specific row or column must be return `true` so that it
can be printed, *i.e* the set of filters has an `AND` logic.

If the keyword is set to `nothing`, which is the default, then no filtering will
be applied to the data.

!!! note

    The filters do not change the row and column numbering for the others
    modifiers such as column width specification, formatters, and highlighters.
    Thus, for example, if only the 4-th row is printed, then it will also be
    referenced inside the formatters and highlighters as 4 instead of 1.

---

# Pretty table text back-end

This back-end produces text tables. This back-end can be used by selecting
`back-end = :text`.

# Keywords

* `border_crayon`: Crayon to print the border.
* `header_crayon`: Crayon to print the header.
* `subheaders_crayon`: Crayon to print sub-headers.
* `rownum_header_crayon`: Crayon for the header of the column with the row
                          numbers.
* `text_crayon`: Crayon to print default text.
* `autowrap`: If `true`, then the text will be wrapped on spaces to fit the
              column. Notice that this function requires `linebreaks = true` and
              the column must have a fixed size (see `columns_width`).
* `body_hlines`: A vector of `Int` indicating row numbers in which an additional
                 horizontal line should be drawn after the row. Notice that
                 numbers lower than 1 and equal or higher than the number of
                 printed rows will be neglected. This vector will be appended to
                 the one in `hlines`, but the indices here are related to the
                 printed rows of the body. Thus, if `1` is added to
                 `body_hlines`, then a horizontal line will be drawn after the
                 first data row. (**Default** = `Int[]`)
* `body_hlines_format`: A tuple of 4 characters specifying the format of the
                        horizontal lines that will be drawn by `body_hlines`.
                        The characters must be the left intersection, the middle
                        intersection, the right intersection, and the row. If it
                        is `nothing`, then it will use the same format specified
                        in `tf`. (**Default** = `nothing`)
* `columns_width`: A set of integers specifying the width of each column. If the
                   width is equal or lower than 0, then it will be automatically
                   computed to fit the large cell in the column. If it is
                   a single integer, then this number will be used as the size
                   of all columns. (**Default** = 0)
* `crop`: Select the printing behavior when the data is bigger than the
          available display size (see `display_size`). It can be `:both` to crop
          on vertical and horizontal direction, `:horizontal` to crop only on
          horizontal direction, `:vertical` to crop only on vertical direction,
          or `:none` to do not crop the data at all. If the `io` has
          `:limit => true`, then `crop` is set to `:both` by default.
          Otherwise, it is set to `:none` by default.
* `crop_num_lines_at_beginning`: Number of lines to be left at the beginning of
                                 the printing when vertically cropping the
                                 output. Notice that the lines required to show
                                 the title are automatically computed.
                                 (**Default** = 0)
* `crop_subheader`: If `true`, then the sub-header size will not be taken into
                    account when computing the column size. Hence, the print
                    algorithm can crop it to save space. This has no effect if
                    the user selects a fixed column width.
                    (**Default** = `false`)
* `continuation_row_alignment`: A symbol that defines the alignment of the cells
                                in the continuation row. This row is printed if
                                the table is vertically cropped.
                                (**Default** = `:c`)
* `display_size`: A tuple of two integers that defines the display size (num. of
                  rows, num. of columns) that is available to print the table.
                  It is used to crop the data depending on the value of the
                  keyword `crop`. Notice that if a dimension is not positive,
                  then it will be treated as unlimited.
                  (**Default** = `displaysize(io)`)
* `ellipsis_line_skip`: An integer defining how many lines will be skipped from
                        showing the ellipsis that indicates the text was
                        cropped. (**Default** = 0)
* `equal_columns_width`: If `true`, then all the columns will have the same
                         width. (**Default** = `false`)
* `highlighters`: An instance of `Highlighter` or a tuple with a list of
                  text highlighters (see the section `Text highlighters`).
* `hlines`: This variable controls where the horizontal lines will be drawn. It
            can be `nothing`, `:all`, `:none` or a vector of integers.
    - If it is `nothing`, which is the default, then the configuration will be
      obtained from the table format in the variable `tf` (see `TextFormat`).
    - If it is `:all`, then all horizontal lines will be drawn.
    - If it is `:none`, then no horizontal line will be drawn.
    - If it is a vector of integers, then the horizontal lines will be drawn
      only after the rows in the vector. Notice that the top line will be drawn
      if `0` is in `hlines`, and the header and subheaders are considered as
      only 1 row. Furthermore, it is important to mention that the row number in
      this variable is related to the **printed rows**. Thus, it is affected by
      filters, and by the option to suppress the header `noheader`. Finally, for
      convenience, the top and bottom lines can be drawn by adding the symbols
      `:begin` and `:end` to this vector, respectively, and the line after the
      header can be drawn by adding the symbol `:header`.
  !!! info

      The values of `body_hlines` will be appended to this vector. Thus,
      horizontal lines can be drawn even if `hlines` is `:none`.

  (**Default** = `nothing`)
* `linebreaks`: If `true`, then `\\n` will break the line inside the cells.
                (**Default** = `false`)
* `maximum_columns_width`: A set of integers specifying the maximum width of
                           each column. If the width is equal or lower than 0,
                           then it will be ignored. If it is a single integer,
                           then this number will be used as the maximum width
                           of all columns. Notice that the parameter
                           `columns_width` has precedence over this one.
                           (**Default** = 0)
* `minimum_columns_width`: A set of integers specifying the minimum width of
                           each column. If the width is equal or lower than 0,
                           then it will be ignored. If it is a single integer,
                           then this number will be used as the minimum width
                           of all columns. Notice that the parameter
                           `columns_width` has precedence over this one.
                           (**Default** = 0)
* `newline_at_end`: If `false`, then the table will not end with a newline
                    character. (**Default** = `true`)
* `noheader`: If `true`, then the header will not be printed. Notice that all
              keywords and parameters related to the header and sub-headers will
              be ignored. (**Default** = `false`)
* `nosubheader`: If `true`, then the sub-header will not be printed, *i.e.* the
                 header will contain only one line. Notice that this option has
                 no effect if `noheader = true`. (**Default** = `false`)
* `omitted_cell_summary_crayon`: Crayon used to print the omitted cell summary.
* `overwrite`: If `true`, then the same number of lines in the printed table
               will be deleted from the output `io`. This can be used to update
               the table in the display continuously. (**Default** = `false`)
* `row_number_alignment`: Select the alignment of the row number column (see the
                          section `Alignment`). (**Default** = `:r`)
* `row_number_column_title`: The title of the column that shows the row numbers.
                             (**Default** = "Row")
* `show_omitted_cell_summary`: If `true`, then a summary will be printed after
                               the table with the number of columns and rows
                               that were omitted. (**Default** = `true`)
* `show_row_number`: If `true`, then a new column will be printed showing the
                     row number. (**Default** = `false`)
* `tf`: Table format used to print the table (see `TextFormat`).
        (**Default** = `tf_unicode`)
* `title_autowrap`: If `true`, then the title text will be wrapped considering
                    the title size. Otherwise, lines larger than the title size
                    will be cropped. (**Default** = `false`)
* `title_crayon`: Crayon to print the title.
* `title_same_width_as_table`: If `true`, then the title width will match that
                               of the table. Otherwise, the title size will be
                               equal to the display width.
                               (**Default** = `false`)
* `vcrop_mode`: This variable defines the vertical crop behavior. If it is
                `:bottom`, then the data, if required, will be cropped in the
                bottom. On the other hand, if it is `:middle`, then the data
                will be cropped in the middle if necessary.
                (**Default** = `:bottom`)
* `vlines`: This variable controls where the vertical lines will be drawn. It
            can be `nothing`, `:all`, `:none` or a vector of integers.
    - If it is `nothing`, which is the default, then the configuration will be
      obtained from the table format in the variable `tf` (see `TextFormat`).
    - If it is `:all`, then all vertical lines will be drawn.
    - If it is `:none`, then no vertical line will be drawn.
    - If it is a vector of integers, then the vertical lines will be drawn only
      after the columns in the vector. Notice that the top line will be drawn if
      `0` is in `vlines`. Furthermore, it is important to mention that the
      column number in this variable is related to the **printed column**. Thus,
      it is affected by filters, and by the options `row_names` and
      `show_row_number`. Finally, for convenience, the left and right vertical
      lines can be drawn by adding the symbols `:begin` and `:end` to this
      vector, respectively, and the line after the header can be drawn by adding
      the symbol `:header`.

  (**Default** = `nothing`)

The keywords `header_crayon` and `subheaders_crayon` can be a `Crayon` or a
`Vector{Crayon}`. In the first case, the `Crayon` will be applied to all the
elements. In the second, each element can have its own crayon, but the length of
the vector must be equal to the number of columns in the data.

## Crayons

A `Crayon` is an object that handles a style for text printed on terminals. It
is defined in the package
[Crayons.jl](https://github.com/KristofferC/Crayons.jl). There are many options
available to customize the style, such as foreground color, background color,
bold text, etc.

A `Crayon` can be created in two different ways:

```julia-repl
julia> Crayon(foreground = :blue, background = :black, bold = :true)

julia> crayon"blue bg:black bold"
```

For more information, see the package documentation.

## Text highlighters

A set of highlighters can be passed as a `Tuple` to the `highlighters` keyword.
Each highlighter is an instance of the structure `Highlighter` that contains
three fields:

* `f`: Function with the signature `f(data,i,j)` in which should return `true`
       if the element `(i,j)` in `data` must be highlighter, or `false`
       otherwise.
* `fd`: Function with the signature `f(h,data,i,j)` in which `h` is the
        highlighter. This function must return the `Crayon` to be applied to the
        cell that must be highlighted.
* `crayon`: The `Crayon` to be applied to the highlighted cell if the default
            `fd` is used.

The function `f` has the following signature:

    f(data, i, j)

in which `data` is a reference to the data that is being printed, and `i` and
`j` are the element coordinates that are being tested. If this function returns
`true`, then the cell `(i,j)` will be highlighted.

If the function `f` returns true, then the function `fd(h,data,i,j)` will be
called and must return a `Crayon` that will be applied to the cell.

A highlighter can be constructed using three helpers:

    Highlighter(f::Function; kwargs...)

where it will construct a `Crayon` using the keywords in `kwargs` and apply it
to the highlighted cell,

    Highlighter(f::Function, crayon::Crayon)

where it will apply the `crayon` to the highlighted cell, and

    Highlighter(f::Function, fd::Function)

where it will apply the `Crayon` returned by the function `fd` to the
highlighted cell.

!!! info

    If only a single highlighter is wanted, then it can be passed directly to
    the keyword `highlighter` without being inside a `Tuple`.

!!! note

    If multiple highlighters are valid for the element `(i,j)`, then the applied
    style will be equal to the first match considering the order in the tuple
    `highlighters`.

!!! note

    If the highlighters are used together with [Formatters](@ref), then the
    change in the format **will not** affect the parameter `data` passed to the
    highlighter function `f`. It will always receive the original, unformatted
    value.

---

# Pretty table HTML backend

This backend produces HTML tables. This backend can be used by selecting
`backend = :html`.

# Keywords

* `highlighters`: An instance of `HTMLHighlighter` or a tuple with a list of
                  HTML highlighters (see the section `HTML highlighters`).
* `linebreaks`: If `true`, then `\\n` will be replaced by `<br>`.
                (**Default** = `false`)
* `noheader`: If `true`, then the header will not be printed. Notice that all
              keywords and parameters related to the header and sub-headers will
              be ignored. (**Default** = `false`)
* `nosubheader`: If `true`, then the sub-header will not be printed, *i.e.* the
                 header will contain only one line. Notice that this option has
                 no effect if `noheader = true`. (**Default** = `false`)
* `standalone`: If `true`, then a complete HTML page will be generated.
                Otherwise, only the content between the tags `<table>` and
                `</table>` will be printed (with the tags included).
                (**Default** = `true`)
* `tf`: An instance of the structure `HTMLTableFormat` that defines the general
        format of the HTML table.

## HTML highlighters

A set of highlighters can be passed as a `Tuple` to the `highlighters` keyword.
Each highlighter is an instance of the structure [`HTMLHighlighter`](@ref). It
contains the following two public fields:

* `f`: Function with the signature `f(data,i,j)` in which should return `true`
       if the element `(i,j)` in `data` must be highlighted, or `false`
       otherwise.
* `fd`: Function with the signature `f(h,data,i,j)` in which `h` is the
        highlighter. This function must return the `HTMLDecoration` to be
        applied to the cell that must be highlighted.

The function `f` has the following signature:

    f(data, i, j)

in which `data` is a reference to the data that is being printed, and `i` and
`j` are the element coordinates that are being tested. If this function returns
`true`, then the highlight style will be applied to the `(i,j)` element.
Otherwise, the default style will be used.

If the function `f` returns true, then the function `fd(h,data,i,j)` will be
called and must return an element of type `HTMLDecoration` that contains the
decoration to be applied to the cell.

A HTML highlighter can be constructed using two helpers:

    HTMLHighlighter(f::Function, decoration::HTMLDecoration)

    HTMLHighlighter(f::Function, fd::Function)

The first will apply a fixed decoration to the highlighted cell specified in
`decoration` whereas the second let the user select the desired decoration by
specifying the function `fd`.

!!! info

    If only a single highlighter is wanted, then it can be passed directly to
    the keyword `highlighter` without being inside a `Tuple`.

!!! note

    If multiple highlighters are valid for the element `(i,j)`, then the applied
    style will be equal to the first match considering the order in the tuple
    `highlighters`.

!!! note

    If the highlighters are used together with [Formatters](@ref), then the
    change in the format **will not** affect the parameter `data` passed to the
    highlighter function `f`. It will always receive the original, unformatted
    value.

---

# Pretty table LaTeX backend

This backend produces LaTeX tables. This backend can be used by selecting
`backend = :latex`.

# Keywords

* `body_hlines`: A vector of `Int` indicating row numbers in which an additional
                 horizontal line should be drawn after the row. Notice that
                 numbers lower than 1 and equal or higher than the number of
                 printed rows will be neglected. This vector will be appended to
                 the one in `hlines`, but the indices here are related to the
                 printed rows of the body. Thus, if `1` is added to
                 `body_hlines`, then a horizontal line will be drawn after the
                 first data row. (**Default** = `Int[]`)
* `highlighters`: An instance of `LatexHighlighter` or a tuple with a list of
                  LaTeX highlighters (see the section `LaTeX highlighters`).
* `hlines`: This variable controls where the horizontal lines will be drawn. It
            can be `nothing`, `:all`, `:none` or a vector of integers.
    - If it is `nothing`, which is the default, then the configuration will be
      obtained from the table format in the variable `tf` (see
      `LatexTableFormat`).
    - If it is `:all`, then all horizontal lines will be drawn.
    - If it is `:none`, then no horizontal line will be drawn.
    - If it is a vector of integers, then the horizontal lines will be drawn
      only after the rows in the vector. Notice that the top line will be drawn
      if `0` is in `hlines`, and the header and subheaders are considered as
      only 1 row. Furthermore, it is important to mention that the row number in
      this variable is related to the **printed rows**. Thus, it is affected by
      filters, and by the option to suppress the header `noheader`. Finally, for
      convenience, the top and bottom lines can be drawn by adding the symbols
      `:begin` and `:end` to this vector, respectively, and the line after the
      header can be drawn by adding the symbol `:header`.
  !!! info

      The values of `body_hlines` will be appended to this vector. Thus,
      horizontal lines can be drawn even if `hlines` is `:none`.

  (**Default** = `nothing`)
* `longtable_footer`: The string that will be drawn in the footer of the tables
                      before a page break. This only works if `table_type` is
                      `:longtable`. If it is `nothing`, then no footer will be
                      used. (**Default** = `nothing`)
* `noheader`: If `true`, then the header will not be printed. Notice that all
              keywords and parameters related to the header and sub-headers will
              be ignored. (**Default** = `false`)
* `nosubheader`: If `true`, then the sub-header will not be printed, *i.e.* the
                 header will contain only one line. Notice that this option has
                 no effect if `noheader = true`. (**Default** = `false`)
* `row_number_alignment`: Select the alignment of the row number column (see the
                          section `Alignment`). (**Default** = `:r`)
* `table_type`: Select which LaTeX environment will be used to print the table.
                Currently supported options are `:tabular` for `tabular` or
                `:longtable` for `longtable`. (**Default** = `:tabular`)
* `tf`: An instance of the structure `LatexTableFormat` that defines the general
        format of the LaTeX table.
* `vlines`: This variable controls where the vertical lines will be drawn. It
            can be `:all`, `:none` or a vector of integers. In the first case
            (the default behavior), all vertical lines will be drawn. In the
            second case, no vertical line will be drawn. In the third case,
            the vertical lines will be drawn only after the columns in the
            vector. Notice that the left border will be drawn if `0` is in
            `vlines`. Furthermore, it is important to mention that the column
            number in this variable is related to the **printed columns**. Thus,
            it is affected by filters, and by the columns added using the
            variable `show_row_number`. Finally, for convenience, the left and
            right border can be drawn by adding the symbols `:begin` and `:end`
            to this vector, respectively. (**Default** = `:none`)
* `wrap_table`: This variable controls whether to wrap the table in a `table`
               environment. Defaults to `true`. When `false`, the printed
               table begins with `\begin{tabular}` rather than `\begin{table}`.
               Does not work when using the `:longtable` table type.

## LaTeX highlighters

A set of highlighters can be passed as a `Tuple` to the `highlighters` keyword.
Each highlighter is an instance of the structure `LatexHighlighter`. It contains
the following two fields:

* `f`: Function with the signature `f(data,i,j)` in which should return `true`
       if the element `(i,j)` in `data` must be highlighted, or `false`
       otherwise.
* `fd`: A function with the signature `f(data,i,j,str)::String` in which
        `data` is the matrix, `(i,j)` is the element position in the table, and
        `str` is the data converted to string. This function must return a
        string that will be placed in the cell.

The function `f` has the following signature:

    f(data, i, j)

in which `data` is a reference to the data that is being printed, `i` and `j`
are the element coordinates that are being tested. If this function returns
`true`, then the highlight style will be applied to the `(i,j)` element.
Otherwise, the default style will be used.

If the function `f` returns true, then the function `fd(data,i,j,str)` will be
called and must return the LaTeX string that will be placed in the cell.

There are two helpers that can be used to create LaTeX highlighters:

    LatexHighlighter(f::Function, envs::Union{String,Vector{String}})

    LatexHighlighter(f::Function, fd::Function)

The first will apply recursively all the LaTeX environments in `envs` to the
highlighted text whereas the second let the user select the desired decoration
by specifying the function `fd`.

Thus, for example:

    LatexHighlighter((data,i,j)->true, ["textbf", "small"])

will wrap all the cells in the table in the following environment:

    \\textbf{\\small{<Cell text>}}

!!! info

    If only a single highlighter is wanted, then it can be passed directly to
    the keyword `highlighter` without being inside a `Tuple`.

!!! note

    If multiple highlighters are valid for the element `(i,j)`, then the applied
    style will be equal to the first match considering the order in the tuple
    `highlighters`.

!!! note

    If the highlighters are used together with [Formatters](@ref), then the
    change in the format **will not** affect the parameter `data` passed to the
    highlighter function `f`. It will always receive the original, unformatted
    value.

---

# Formatters

The keyword `formatters` can be used to pass functions to format the values in
the columns. It must be a tuple of functions in which each function has the
following signature:

    f(v, i, j)

where `v` is the value in the cell, `i` is the row number, and `j` is the column
number. Thus, it must return the formatted value of the cell `(i,j)` that has
the value `v`. Notice that the returned value will be converted to string after
using the function `sprint`.

This keyword can also be a single function, meaning that only one formatter is
available, or `nothing`, meaning that no formatter will be used.

For example, if we want to multiply all values in odd rows of the column 2 by π,
then the formatter should look like:

    formatters = (v,i,j) -> (j == 2 && isodd(i)) ? v*π : v

If multiple formatters are available, then they will be applied in the same
order as they are located in the tuple. Thus, for the following `formatters`:

    formatters = (f1, f2, f3)

each element `v` in the table (i-th row and j-th column) will be formatted by:

    v = f1(v,i,j)
    v = f2(v,i,j)
    v = f3(v,i,j)

Thus, the user must be ensure that the type of `v` between the calls are
compatible.

"""
@inline function pretty_table(data; kwargs...)
    io = IOContext(stdout, :limit => true)
    _pretty_table(io, data, String[]; kwargs...)
end

@inline function pretty_table(data, header::AbstractVecOrMat; kwargs...)
    io = IOContext(stdout, :limit => true)
    _pretty_table(io, data, header; kwargs...)
end

# This definition is required to avoid ambiguities.
@inline function pretty_table(data::AbstractVecOrMat,
                              header::AbstractVecOrMat;
                              kwargs...)
    io = IOContext(stdout, :limit => true)
    _pretty_table(io, data, header; kwargs...)
end

# This definition is required to avoid ambiguities.
pretty_table(io::IO, data::AbstractVecOrMat; kwargs...) =
    _pretty_table(io, data, String[]; kwargs...)

pretty_table(io::IO, data; kwargs...) =
    _pretty_table(io, data, String[]; kwargs...)

pretty_table(io::IO, data, header::AbstractVecOrMat; kwargs...) =
    _pretty_table(io, data, header; kwargs...)

# This definition is required to avoid ambiguities.
pretty_table(::Type{String}, data::AbstractVecOrMat; kwargs...) =
    pretty_table(String, data, String[]; kwargs...)

pretty_table(::Type{String}, data; kwargs...) =
    pretty_table(String, data, String[]; kwargs...)

function pretty_table(::Type{String}, data, header::AbstractVecOrMat; kwargs...)
    io = IOBuffer()
    _pretty_table(io, data, header; kwargs...)
    return String(take!(io))
end
