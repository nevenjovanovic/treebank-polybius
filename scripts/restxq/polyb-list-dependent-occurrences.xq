(: Explore Polybius's treebanks :)
(: for a relation, return count of sentences by count of dependent nodes :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace polyb = "http://croala.ffzg.unizg.hr/polyb" at '../../repo/polyb.xqm';

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := "Occurrences of counts of dependent nodes for a syntactic relation in the Polybius treebank";
declare variable $content := "For a syntactic relation, display breakdown by number of dependent nodes and by number of occurrences in the Polybius's treebank from the AGLDT project.";
declare variable $keywords := "Ancient Greek language, Prague dependency treebank, syntax, XML, XQuery, scholarly edition, history of Greek language, Open Philology, Perseus Digital Library, syntactic relation, Polybius";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("polyboccur/{$relation}")
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
  function page:polyboccurdepnodes($relation)
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
<p>Occurrences of counts of dependent nodes for the syntactic relation { $relation } in Polybius, Histories 1.</p>
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

	{ polyb:analysis($relation) }
  
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




