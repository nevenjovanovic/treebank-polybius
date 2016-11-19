declare function local:get_child($sentence , $sentence_id , $word){
  for $w in $word
  let $w_id := $w/@id/string()
  let $w_child := if ($sentence/word[@head=$w_id]) then $sentence/word[@head=$w_id] else "0"
  let $child_count := count($w_child)
  return element result { 
  $sentence_id ,
  element id { $w_id } , 
  element children { $w_child } , 
  element count { $child_count } }
};
for $s in //sentence
let $s_id := $s/@id
for $sbj in $s/word[@relation="SBJ"]
return element subject {
  $s_id ,
  $sbj ,
  local:get_child($s, $s_id , $sbj)/*[not(name()="id")]
}