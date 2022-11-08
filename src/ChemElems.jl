
"""
    ChemElems
This struct is a container for elements and provides access by number, symbol, or name. It is not exported.
"""
struct ChemElems
    data::Vector{ChemElem}
    bynumber::Dict{Int, Int}
    byname::Dict{String, Int}
    bysymbol::Dict{Symbol, Int}
    ChemElems(data::Vector{ChemElem}) = new(
        data,
        Dict{Int, Int}(data[i].atomic_number=>i for i in eachindex(data)),
        Dict{String, Int}(lowercase(data[i].name)=>i for i in eachindex(data)),
        Dict{Symbol, Int}(Symbol(data[i].symbol)=>i for i in eachindex(data))
        )
end
