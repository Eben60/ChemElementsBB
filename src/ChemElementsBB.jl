"""
    ChemElementsBB
Package TODO blabla. Exports them as `chem_elements`, 
enabling access by name, symbol, or atomic number.
"""
module ChemElementsBB




include("ChemElem_def.jl")
include("ChemElems.jl")
include("elements_init.jl")
include("overloads.jl")


export ChemElem # struct definition
export chem_elements # all elements data

# import these explicitly for legacy (formerly PeriodicTable.jl based) applications
elements = chem_elements
Element = ChemElem 

els = chem_elements # import this short form if you like

end  # module Mendeleev
