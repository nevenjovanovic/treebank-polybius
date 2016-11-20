import module namespace polyb = "http://croala.ffzg.unizg.hr/polyb" at '../repo/polyb.xqm';

(: call functions locally to better see what happens :)
(: polyb:distrels() :)
(: polyb:table( ("Sentences", "Words") , polyb:countsw()) :)
(: polyb:table(("Sentence number", "Dependent nodes") , polyb:stats("SBJ")) :)
(: polyb:analysis("ADV_CO") :)
polyb:table( ("Morph code", "Occurrences") , polyb:morph ("SBJ", 2))
