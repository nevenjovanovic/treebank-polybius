for $w in collection("polybius-db-t")//w[@relation="SBJ"]
let $s_id := $w/ancestor::sentence/@id
let $depth := count($w/descendant-or-self::w)
order by $depth descending , xs:integer(data($s_id))
return element s {
  $s_id ,
  $depth
}