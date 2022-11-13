"""
    ChemElementsBB
Package TODO blabla. Exports them as `chem_els`, 
enabling access by name, symbol, or atomic number.
"""
module ChemElementsBB




include("ChemElem_def.jl")
include("elements_init.jl")
include("overloads.jl")
include("syntax-sugar.jl")


export ChemElemBB # struct definition
export chem_els # all elements data
export @import_els 

# import these explicitly for legacy (formerly PeriodicTable.jl based) applications
elements = chem_els
Element = ChemElemBB 

els = chem_els # import this short form if you like

end  # module ChemElementsBB
