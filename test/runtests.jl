using ChemElementsBB

using Test

@import_els K Ca P O

@test K / (K + Ca + P + 4*O) ≈ 0.22451440791379498

@test K === chem_els["potassium"]
@test Ca === chem_els[:Ca]
@test P === chem_els[15] 
@test O === chem_els.O
