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