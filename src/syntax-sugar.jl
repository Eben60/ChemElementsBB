function by_str2sym(s)
    s = Symbol(s)
    ! haskey(chem_els, s) && throw(DomainError(s, "Element with symbol $s not found"))
    return chem_els[s]
end

function parse_elem_range(x)
    isOK = true
    isOK &= (x isa Expr)
    if isOK
        isOK &= (x.head == :call) && 
            (length(x.args) == 3) && 
            (x.args[1] == :(:)) &&
            (x.args[2] isa Symbol) &&
            (x.args[3] isa Symbol)
    end
    ! isOK && throw(DomainError(x, "Argument $x must be a Symbol or a range of Symbols e.g. H:U "))     
    return (;start = x.args[2], stop = x.args[3])
end

function get_elem_range(x)
    r = parse_elem_range(x)
    e1 = chem_els[r.start].number
    e2 = chem_els[r.stop].number
    e1>e2 && throw(ArgumentError("In the elements range $x the atomic number of the first element is larger than that of the second one"))
    return [e.symbol for e in chem_els[e1:e2]]
end
   

# macro import_els(args...)
#     v = [:($(esc(x)) = ChemElementsBB.by_str2sym($(string(x)))) for x in args]
#     return Expr(:block, v...)
# end

macro import_els(args...)
    symbs = Symbol[]
    for x in args
        if x isa Symbol
            push!(symbs, x)
        else
            symbs = vcat(symbs, get_elem_range(x))
        end
    end
    unique!(symbs)
    v = [:($(esc(x)) = ChemElementsBB.by_str2sym($(string(x)))) for x in symbs]
    return Expr(:block, v...)
end

# export @m2
