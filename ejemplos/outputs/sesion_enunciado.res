Variables libres: {}
Variables ligadas: {x,y}
λy.(y)
Variables libres: {b,z,a}
Variables ligadas: {f,x,z}
EXPR = (λf.(f b)) (λx.(λz.(z)) z) a
CONV[z -> z'] = (λf.(f b)) (λx.(λz'.(z')) z) a
SUST[x:=z] = (λf.(f b)) λz'.(z') a
SUST[f:=λz'.(z')] = (λz'.(z') b) a
SUST[z':=b] = b a
b a
