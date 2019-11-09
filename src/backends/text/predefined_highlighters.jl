#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
#
#   Pre-defined highlighters for the text backend.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#

export thl_cell, thl_col, thl_row, thl_lt, thl_leq, thl_gt, thl_geq, thl_value

"""
    function thl_cell(i::Number, j::Number, crayon::Crayon)

Highlight the cell `(i,j)` with the crayon `crayon`.

    function thl_cell(cells::AbstractVector{NTuple(2,Int)}, crayon::Crayon)

Highlights all the cells in `cells` with the crayon `crayon`.

"""
thl_cell(i::Number, j::Number, crayon::Crayon) = TextHighlighter(
    f = (data,x,y)->begin
        return (x == i) && (y == j)
    end,
    crayon = crayon
)

thl_cell(cells::AbstractVector{NTuple{2,Int}}, crayon::Crayon) = TextHighlighter(
    f = (data,x,y)->begin
        return (x,y) ∈ cells
    end,
    crayon = crayon
)

"""
    function thl_col(i::Number, crayon::Crayon)

Highlight the entire column `i` with the crayon `crayon`.

    function thl_col(cols::AbstractVector{Int}, crayon::Crayon)

Highlights all the columns in `cols` with the crayon `crayon`.

"""
thl_col(j::Number, crayon::Crayon) = TextHighlighter(
    f = (data,x,y)->begin
        return y == j
    end,
    crayon = crayon
)

thl_col(cols::AbstractVector{Int}, crayon::Crayon) = TextHighlighter(
    f = (data,x,y)->begin
        return y ∈ cols
    end,
    crayon = crayon
)

"""
    function thl_row(i::Number, crayon::Crayon)

Highlight the entire row `i` with the crayon `crayon`.

    function thl_row(rows::AbstractVector{Int}, crayon::Crayon)

Highlights all the rows in `rows` with the crayon `crayon`.

"""
thl_row(i::Number, crayon::Crayon) = TextHighlighter(
    f = (data,x,y)->begin
        return x == i
    end,
    crayon = crayon
)

thl_row(rows::AbstractVector{Int}, crayon::Crayon) = TextHighlighter(
    f = (data,x,y)->begin
        return x ∈ rows
    end,
    crayon = crayon
)

"""
    function thl_lt(n::Number)

Highlight all elements that < `n`.

"""
thl_lt(n::Number) = TextHighlighter(
    f = (data,i,j)->begin
        if applicable(<,data[i,j],n) && data[i,j] < n
            return true
        else
            return false
        end
    end,
    crayon = Crayon(bold       = true,
                    foreground = :red)
)

"""
    function thl_leq(n::Number)

Highlight all elements that ≤ `n`.

"""
thl_leq(n::Number) = TextHighlighter(
    f = (data,i,j)->begin
        if applicable(≤,data[i,j],n) && data[i,j] ≤ n
            return true
        else
            return false
        end
    end,
    crayon = Crayon(bold       = true,
                    foreground = :red)
)

"""
    function thl_gt(n::Number)

Highlight all elements that > `n`.

"""
thl_gt(n::Number) = TextHighlighter(
    f = (data,i,j)->begin
        if applicable(>,data[i,j],n) && data[i,j] > n
            return true
        else
            return false
        end
    end,
    crayon = Crayon(bold       = true,
                    foreground = :blue)
)

"""
    function thl_geq(n::Number)

Highlight all elements that ≥ `n`.

"""
thl_geq(n::Number) = TextHighlighter(
    f = (data,i,j)->begin
        if applicable(≥,data[i,j],n) && data[i,j] ≥ n
            return true
        else
            return false
        end
    end,
    crayon = Crayon(bold       = true,
                    foreground = :blue)
)

"""
    function thl_value(v::Any)

Highlight all the values that matches `data[i,j] == v`.

"""
thl_value(v) = TextHighlighter(
    f = (data,i,j)->data[i,j] == v,
    crayon = Crayon(bold       = true,
                    foreground = :yellow)
)
