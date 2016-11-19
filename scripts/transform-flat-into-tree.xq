(: transform flat sentences into nested xml trees :)
declare function local:children($sentence , $word ){
let $attrs := $word/@*
let $w_id := $word/@id
let $w_children := $sentence/word[@head=$w_id]
return element w {
  $attrs,
  for $ww in $w_children
  return local:children($sentence, $ww)
}
};

element treebank {
for $s in //sentence
let $s_id := $s/@id
return element sentence {
  $s_id ,
for $w in $s/word[@head="0"]
return local:children($s, $w)
}
}