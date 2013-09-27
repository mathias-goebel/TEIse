xquery version "3.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb"; 
let $item := request:get-parameter("uri", "11f78.0")

let $collection := xmldb:create-collection('/db/apps/sade/sandbox/tg-extract/', $item)
let $login := xmldb:login($collection, '', '')

(:  GET TIMESTAMP  :)
let $dateTime := string(current-dateTime())
let $timestamp := concat(substring($dateTime,1,4),substring($dateTime,6,2),substring($dateTime,9,2),substring($dateTime,12,2),substring($dateTime,15,2),substring($dateTime,18,2))

(:  GET AND TRANSFORM DOCUMENTS  :)
  let $doc := doc(concat('http://textgridrep.org/services/tgcrud-public/rest/textgrid:',$item ,'/data'))
(:let $doc := doc('/apps/sade/sandbox/tg-extract/goethe_faust1.xml'):)
let $xsl1 := doc('/apps/sade/sandbox/tg-extract/sp.xsl')
let $xsl2 := doc('/apps/sade/sandbox/tg-extract/sort.xsl')
let $xsl3 := doc('/apps/sade/sandbox/tg-extract/extract.xsl')

let $one := transform:transform($doc, $xsl1, <parameters><param name="graphicsPrefix" value="/digitallibrary/servlet/Scaler?dw=800&amp;fn="/></parameters>)
let $two := transform:transform($one, $xsl2, <parameters><param name="graphicsPrefix" value="/digitallibrary/servlet/Scaler?dw=800&amp;fn="/></parameters>)

for $speaker in $two//speak/@who
    let $file-name := replace($speaker, " ", "_")
    let $three := transform:transform($two, $xsl3, <parameters><param name="who" value="{$speaker}"/></parameters>)
    let $store-return-status := xmldb:store($collection, $file-name, $three, 'text/text')
return $speaker
