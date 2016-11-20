module namespace polyb = "http://croala.ffzg.unizg.hr/polyb";
(: Functions to explore Polybius's treebanks :)

(: count sentence and word nodes in the treebank doc :)

declare function polyb:countsw(){
  element tbody {
    element thead {
      element tr {
        element th {"Sentences"},
        element th {"Words"}
      }
    },
    
    let $db := db:open("polybius-db")//treebank[@cts="urn:cts:greekLit:tlg0543.tlg001.perseus-grc1.tb"]/body
    let $scount := count($db/sentence)
    let $wcount := count($db//word)
    return
    element tr {
      element td {$scount},
      element td {$wcount}
    }
  }
};

declare function polyb:distrels(){
  element tbody {
    element thead {
      element tr {
        element th {"Function"},
        element th {"Number of nodes"}
      }
    },
    
    let $db := db:open("polybius-db")//treebank[@cts="urn:cts:greekLit:tlg0543.tlg001.perseus-grc1.tb"]/body
    for $rels in $db//word
    let $fvalue := $rels/@relation/string()
    group by $fvalue
    order by $fvalue
    return
    element tr {
      element td {$fvalue},
      element td {count($rels)}
    }
  }
};

(: return a table :)
declare function polyb:table ($labels, $tbody) {
  element table {
    element thead {
      element tr {
      for $l in $labels
      return element th { $l }
    }
    },
    $tbody
  } 
};

(: return a table with sentence id and number of children elements for a relation :)
declare function polyb:stats($relation){
let $result :=  element tbody {
for $w in collection("polybius-db-t")//w[@relation=$relation]
let $s_id := $w/ancestor::sentence/@id
let $depth := count($w/descendant-or-self::w)
order by $depth descending , xs:integer(data($s_id))
return element tr {
  element td { $s_id , data($s_id) } ,
  element td { $depth }
}
}
return if ($result//td) then $result
else element p {
  "No such relation in the database!"
}

};

declare function polyb:analysis($relation){
let $stat := polyb:stats($relation)
return if ($stat//td) then
  let $body := element tbody {
  for $s in $stat//td[2]
  let $value := xs:integer($s/text())
  group by $value
  return element tr {
    element td { $value },
    element td { count($s)}
  }
}
let $labels := ("Number of children nodes", "Occurrences")
return polyb:table($labels , $body)
else $stat
};