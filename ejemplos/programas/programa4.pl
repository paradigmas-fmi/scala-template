%% Base de conocimientos de ejemplo: predicados de aridad 0
%% (ejemplo es_cebra del enunciado, en sintaxis simplificada)

es_cebra():-es_ungulado(),tiene_rayas_negras().
es_ungulado():-rumia(),es_mamifero().
es_ungulado():-es_mamifero(),tiene_pezunas().
rumia():-false.

es_mamifero().
tiene_pezunas().
tiene_rayas_negras().
