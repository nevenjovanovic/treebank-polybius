module namespace polyb = "http://croala.ffzg.unizg.hr/polyb";

(: HTML functions :)

(: helper function for header, with meta :)
declare function polyb:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, Department of Classical Philology, Faculty of Humanities and Social Sciences, University of Zagreb" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/basexpolyb.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/font-awesome-4.7.0/css/font-awesome.min.css"/>

</head>

};

(: formatting - footer on solr :)
declare function polyb:footerserver () {
let $f := <footer class="footer">
<div class="container">
<h3> </h3>
<h1 class="text-center"><a href="https://github.com/nevenjovanovic/treebank-polybius" class="btn btn-primary-outline btn-lg"><i class="fa fa-github fa-lg"></i> <span class="network-name">Github</span></a></h1>
<div class="row">
<div  class="col-md-3">
</div> 
<div  class="col-md-6">
<p class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/basex/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</p> 
</div>
<div  class="col-md-3"></div></div>
</div>
</footer>
return $f
};

declare function polyb:infodb($dbname) {
  (: return info on croalabib db, with Latin field names :)
let $week := map {
  "name": "nomen",
  "documents": "documenta",
  "timestamp": "de dato"
}
return element table { 
attribute class { "pull-right"},
let $i := db:info($dbname)/databaseproperties
  for $n in ('name','documents','timestamp')
  return 
   element tr {
    element td { map:get($week, $n) } ,
    element td { $i/*[name()=$n] }
  }
}
};

(: Functions to explore Polybius's treebanks :)

(: count sentence and word nodes in the treebank doc :)

declare function polyb:countsw(){
  element tbody {
    let $db := db:open("polybius-db-t")//treebank
    let $scount := count($db/sentence)
    let $wcount := count($db//w)
    return
    element tr {
      element td {$scount},
      element td {$wcount}
    }
  }
};

declare function polyb:distrels(){
  let $labels := ("Function", "Number of nodes")
  let $tbody := element tbody {    
    let $db := db:open("polybius-db-t")//treebank
    for $rels in $db//w
    let $fvalue := $rels/@relation/string()
    group by $fvalue
    order by $fvalue
    return
    element tr {
      element td {$fvalue},
      element td {count($rels)}
    }
  }
  return polyb:table($labels, $tbody)
};

(: return a table :)
declare function polyb:table ($labels, $tbody) {
  element table {
    attribute  class { "table-striped  table-hover table-centered" } ,
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
let $labels := ("Number of dependent nodes", "Number of occurrences")
return polyb:table($labels , $body)
else $stat
};

(: for a relation with a certain number of descendant nodes, return all morphological annotations :)
declare function polyb:morph ($relation, $count) {
  element tbody {
for $w in db:open("polybius-db-t")//sentence//w[@relation=$relation]
let $pos := if ($w/@postag) then $w/@postag else $w/@artificial
where count($w/descendant-or-self::w) = $count
group by $pos
order by $pos
return element tr {
  element td { data($pos)},
  element td { count($w)}
}
}
};