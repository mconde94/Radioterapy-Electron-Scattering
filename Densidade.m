function [ out] = Densidade(r)
global massaVolumica tamanho raio
if (r(1)-tamanho/2)^2+r(2)^2<=raio^2   
        out=massaVolumica*2;       
else   
    out=massaVolumica;   
end
end

