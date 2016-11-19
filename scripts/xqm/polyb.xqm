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