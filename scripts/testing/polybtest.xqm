module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace polyb = "http://croala.ffzg.unizg.hr/polyb" at '../xqm/polyb.xqm';

(: do we have a polybius-db database? :)   

declare %unit:test function test:db-exists() {
  unit:assert(db:exists("polybius-db"))
};

(: do we have a table header? :)

declare %unit:test function test:thead() {
  let $title := polyb:countsw()//tr[parent::thead]/th[2]/text()
  let $w := "Words"
  return unit:assert-equals(xs:string($title), $w)
};

(: do we have treebanks in the database? how many sentences? how many words?  :)

declare %unit:test function test:count-s-w() {
  let $counts := polyb:countsw()//tr[parent::tbody]/td[2]/text()
  return unit:assert(xs:integer($counts))
};

(: can we get a list of @relation attributes? :)

(: can we get count of @relation values? :)