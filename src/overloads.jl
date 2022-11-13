
Base.getindex(e::ChemElems, i::Integer) = e.data[e.bynumber[i]]
Base.getindex(e::ChemElems, i::AbstractString) = e.data[e.byname[lowercase(i)]]
Base.getindex(e::ChemElems, i::Symbol) = e.data[e.bysymbol[i]]
Base.getindex(e::ChemElems, v::AbstractVector) = ChemElemBB[e[i] for i in v]
Base.haskey(e::ChemElems, i::Integer) = haskey(e.bynumber, i)
Base.haskey(e::ChemElems, i::AbstractString) = haskey(e.byname, lowercase(i))
Base.haskey(e::ChemElems, i::Symbol) = haskey(e.bysymbol, i)


# support iterating over ChemElems
Base.eltype(e::ChemElems) = ChemElemBB
Base.length(e::ChemElems) = length(e.data)
Base.iterate(e::ChemElems, state...) = iterate(e.data, state...)
Base.firstindex(e::ChemElems) = firstindex(e.data)
Base.lastindex(e::ChemElems) = lastindex(e.data)

# Since Element equality is determined by atomic number alone...
Base.isequal(elm1::ChemElemBB, elm2::ChemElemBB) = elm1.number == elm2.number

# There is no need to use all the data in Element to calculated the hash
# since Element equality is determined by atomic number alone.
Base.hash(elm::ChemElemBB, h::UInt) = hash(elm.number, h)

Base.isless(elm1::ChemElemBB, elm2::ChemElemBB) = elm1.weight < elm2.weight

# Provide a simple way to iterate over all elements.
Base.eachindex(elms::ChemElems) = eachindex(elms.data)


Base.promote_rule(::Type{T1}, ::Type{T2}) where {T1 <: ChemElemBB} where {T2 <: Real} = Float64
Base.Float64(x::ChemElemBB) = x.weight
Base.:+(x::ChemElemBB, y::ChemElemBB) = +(x.weight, y.weight)
Base.:-(x::ChemElemBB, y::ChemElemBB) = -(x.weight, y.weight)

Base.show(io::IO, cs::ChemElems) = println(io, "List of chemical elements from $(cs[begin].symbol) to $(cs[end].symbol)")
Base.show(io::IO, e::ChemElemBB) = println(io, "$(e.name) ($(e.symbol)) - element $(e.number), m=$(e.weight)")


function Base.getproperty(e::ChemElems, s::Symbol)
    s in fieldnames(ChemElems)  && return getfield(e, s)
    haskey(e.bysymbol, s) && return e.data[e.bysymbol[s]]
    error("type ChemElems has no field $s")
end
