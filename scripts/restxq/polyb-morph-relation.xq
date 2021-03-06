(: Explore Polybius's treebanks :)
(: for a relation with a certain number of dependent nodes, return list of morphology annotations with number of occurrences :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace polyb = "http://croala.ffzg.unizg.hr/polyb" at '../../repo/polyb.xqm';

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := "Morphological annotations for a syntactic relation with a certain number of dependent nodes in the Polybius treebank";
declare variable $content := "For a syntactic relation with a certain number of dependent nodes, display all morphological variants and count of their occurrences in the Polybius's treebank from the AGLDT project.";
declare variable $keywords := "Ancient Greek language, Prague dependency treebank, syntax, morphology, XML, XQuery, scholarly edition, history of Greek language, Open Philology, Perseus Digital Library, syntactic relation, Polybius, occurrences";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("polybmorph/{$relation}/{$count}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:polybmorphcount($relation, $count)
{
  (: HTML template starts here :)

<html>
{ polyb:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Exploring Polybius with dependency trees, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>Occurrences of morphological configurations with { $count } dependent nodes for the syntactic relation { $relation } in Polybius, Histories 1.</p>
<p>Name of the function: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{polyb:infodb('polybius-db-t')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	<div class="table-responsive">

	{ polyb:table( ("Morph code", "Occurrences") , polyb:morph ($relation, $count)) }
  
     </div>
</blockquote>
     <p/>
     </div>
<hr/>
{ polyb:footerserver() }

</body>
</html>
};

return




