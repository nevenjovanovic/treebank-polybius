(: Explore Polybius's treebanks :)
(: return a list of relations :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace polyb = "http://croala.ffzg.unizg.hr/polyb" at '../../repo/polyb.xqm';

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := "Relations in Polybius's treebanks";
declare variable $content := "Display a list of syntactic relations used in annotating Polybius's sentences by the AGLDT project.";
declare variable $keywords := "Ancient Greek language, Prague dependency treebank, syntax, XML, XQuery, scholarly edition, history of Greek language, Open Philology, Perseus Digital Library";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("polybrelations")
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
  function page:polybrelations()
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
<p>A list of syntactic relations in Polybius, Histories 1.</p>
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

	{ polyb:distrels() }
  
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




