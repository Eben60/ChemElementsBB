"""
    ChemElemBB
This struct's fields correspond to only the most basic data pertaining to a chemical element, 
all other data being accessed via properties.
It is exported.
```
    number::Int
    name::String
    symbol::Symbol
```
"""
struct ChemElemBB <: AbstractFloat
    number::Int
    name::String
    symbol::Symbol
    weight::Float64
end

"""
    ChemElems
This struct is a container for elements and provides access by number, symbol, or name. It is not exported.
"""
struct ChemElems
    data::Vector{ChemElemBB}
    bynumber::Dict{Int, Int}
    byname::Dict{String, Int}
    bysymbol::Dict{Symbol, Int}
    ChemElems(data::Vector{ChemElemBB}) = new(
        data,
        Dict{Int, Int}(data[i].number=>i for i in eachindex(data)),
        Dict{String, Int}(lowercase(data[i].name)=>i for i in eachindex(data)),
        Dict{Symbol, Int}(data[i].symbol=>i for i in eachindex(data))
        )
end
