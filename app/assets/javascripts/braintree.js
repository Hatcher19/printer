/*!
 * Braintree End-to-End Encryption Library
 * http://www.braintreepayments.com
 * Copyright (c) 2009-2013 Braintree Payment Solutions
 *
 * JSBN
 * Copyright (c) 2005  Tom Wu
 *
 * Both Licensed under the MIT License.
 * http://opensource.org/licenses/MIT
 *
 * ASN.1 JavaScript decoder
 * Copyright (c) 2008-2009 Lapo Luchini <lapo@lapo.it>
 * Licensed under the ISC License.
 * http://opensource.org/licenses/ISC
 */

Braintree=(function(){function Stream(enc,pos){if(enc instanceof Stream){this.enc=enc.enc;this.pos=enc.pos;}else{this.enc=enc;this.pos=pos;}}
Stream.prototype.get=function(pos){if(pos==undefined)
pos=this.pos++;if(pos>=this.enc.length)
throw'Requesting byte offset '+pos+' on a stream of length '+this.enc.length;return this.enc[pos];}
Stream.prototype.hexDigits="0123456789ABCDEF";Stream.prototype.hexByte=function(b){return this.hexDigits.charAt((b>>4)&0xF)+this.hexDigits.charAt(b&0xF);}
Stream.prototype.hexDump=function(start,end){var s="";for(var i=start;i<end;++i){s+=this.hexByte(this.get(i));switch(i&0xF){case 0x7:s+="  ";break;case 0xF:s+="\n";break;default:s+=" ";}}
return s;}
Stream.prototype.parseStringISO=function(start,end){var s="";for(var i=start;i<end;++i)
s+=String.fromCharCode(this.get(i));return s;}
Stream.prototype.parseStringUTF=function(start,end){var s="",c=0;for(var i=start;i<end;){var c=this.get(i++);if(c<128)
s+=String.fromCharCode(c);else if((c>191)&&(c<224))
s+=String.fromCharCode(((c&0x1F)<<6)|(this.get(i++)&0x3F));else
s+=String.fromCharCode(((c&0x0F)<<12)|((this.get(i++)&0x3F)<<6)|(this.get(i++)&0x3F));}
return s;}
Stream.prototype.reTime=/^((?:1[89]|2\d)?\d\d)(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])([01]\d|2[0-3])(?:([0-5]\d)(?:([0-5]\d)(?:[.,](\d{1,3}))?)?)?(Z|[-+](?:[0]\d|1[0-2])([0-5]\d)?)?$/;Stream.prototype.parseTime=function(start,end){var s=this.parseStringISO(start,end);var m=this.reTime.exec(s);if(!m)
return"Unrecognized time: "+s;s=m[1]+"-"+m[2]+"-"+m[3]+" "+m[4];if(m[5]){s+=":"+m[5];if(m[6]){s+=":"+m[6];if(m[7])
s+="."+m[7];}}
if(m[8]){s+=" UTC";if(m[8]!='Z'){s+=m[8];if(m[9])
s+=":"+m[9];}}
return s;}
Stream.prototype.parseInteger=function(start,end){var len=end-start;if(len>4){len<<=3;var s=this.get(start);if(s==0)
len-=8;else
while(s<128){s<<=1;--len;}
return"("+len+" bit)";}
var n=0;for(var i=start;i<end;++i)
n=(n<<8)|this.get(i);return n;}
Stream.prototype.parseBitString=function(start,end){var unusedBit=this.get(start);var lenBit=((end-start-1)<<3)-unusedBit;var s="("+lenBit+" bit)";if(lenBit<=20){var skip=unusedBit;s+=" ";for(var i=end-1;i>start;--i){var b=this.get(i);for(var j=skip;j<8;++j)
s+=(b>>j)&1?"1":"0";skip=0;}}
return s;}
Stream.prototype.parseOctetString=function(start,end){var len=end-start;var s="("+len+" byte) ";if(len>20)
end=start+20;for(var i=start;i<end;++i)
s+=this.hexByte(this.get(i));if(len>20)
s+=String.fromCharCode(8230);return s;}
Stream.prototype.parseOID=function(start,end){var s,n=0,bits=0;for(var i=start;i<end;++i){var v=this.get(i);n=(n<<7)|(v&0x7F);bits+=7;if(!(v&0x80)){if(s==undefined)
s=parseInt(n/40)+"."+(n%40);else
s+="."+((bits>=31)?"bigint":n);n=bits=0;}
s+=String.fromCharCode();}
return s;}
function ASN1(stream,header,length,tag,sub){this.stream=stream;this.header=header;this.length=length;this.tag=tag;this.sub=sub;}
ASN1.prototype.typeName=function(){if(this.tag==undefined)
return"unknown";var tagClass=this.tag>>6;var tagConstructed=(this.tag>>5)&1;var tagNumber=this.tag&0x1F;switch(tagClass){case 0:switch(tagNumber){case 0x00:return"EOC";case 0x01:return"BOOLEAN";case 0x02:return"INTEGER";case 0x03:return"BIT_STRING";case 0x04:return"OCTET_STRING";case 0x05:return"NULL";case 0x06:return"OBJECT_IDENTIFIER";case 0x07:return"ObjectDescriptor";case 0x08:return"EXTERNAL";case 0x09:return"REAL";case 0x0A:return"ENUMERATED";case 0x0B:return"EMBEDDED_PDV";case 0x0C:return"UTF8String";case 0x10:return"SEQUENCE";case 0x11:return"SET";case 0x12:return"NumericString";case 0x13:return"PrintableString";case 0x14:return"TeletexString";case 0x15:return"VideotexString";case 0x16:return"IA5String";case 0x17:return"UTCTime";case 0x18:return"GeneralizedTime";case 0x19:return"GraphicString";case 0x1A:return"VisibleString";case 0x1B:return"GeneralString";case 0x1C:return"UniversalString";case 0x1E:return"BMPString";default:return"Universal_"+tagNumber.toString(16);}
case 1:return"Application_"+tagNumber.toString(16);case 2:return"["+tagNumber+"]";case 3:return"Private_"+tagNumber.toString(16);}}
ASN1.prototype.content=function(){if(this.tag==undefined)
return null;var tagClass=this.tag>>6;if(tagClass!=0)
return(this.sub==null)?null:"("+this.sub.length+")";var tagNumber=this.tag&0x1F;var content=this.posContent();var len=Math.abs(this.length);switch(tagNumber){case 0x01:return(this.stream.get(content)==0)?"false":"true";case 0x02:return this.stream.parseInteger(content,content+len);case 0x03:return this.sub?"("+this.sub.length+" elem)":this.stream.parseBitString(content,content+len)
case 0x04:return this.sub?"("+this.sub.length+" elem)":this.stream.parseOctetString(content,content+len)
case 0x06:return this.stream.parseOID(content,content+len);case 0x10:case 0x11:return"("+this.sub.length+" elem)";case 0x0C:return this.stream.parseStringUTF(content,content+len);case 0x12:case 0x13:case 0x14:case 0x15:case 0x16:case 0x1A:return this.stream.parseStringISO(content,content+len);case 0x17:case 0x18:return this.stream.parseTime(content,content+len);}
return null;}
ASN1.prototype.toString=function(){return this.typeName()+"@"+this.stream.pos+"[header:"+this.header+",length:"+this.length+",sub:"+((this.sub==null)?'null':this.sub.length)+"]";}
ASN1.prototype.print=function(indent){if(indent==undefined)indent='';document.writeln(indent+this);if(this.sub!=null){indent+='  ';for(var i=0,max=this.sub.length;i<max;++i)
this.sub[i].print(indent);}}
ASN1.prototype.toPrettyString=function(indent){if(indent==undefined)indent='';var s=indent+this.typeName()+" @"+this.stream.pos;if(this.length>=0)
s+="+";s+=this.length;if(this.tag&0x20)
s+=" (constructed)";else if(((this.tag==0x03)||(this.tag==0x04))&&(this.sub!=null))
s+=" (encapsulates)";s+="\n";if(this.sub!=null){indent+='  ';for(var i=0,max=this.sub.length;i<max;++i)
s+=this.sub[i].toPrettyString(indent);}
return s;}
ASN1.prototype.posStart=function(){return this.stream.pos;}
ASN1.prototype.posContent=function(){return this.stream.pos+this.header;}
ASN1.prototype.posEnd=function(){return this.stream.pos+this.header+Math.abs(this.length);}
ASN1.decodeLength=function(stream){var buf=stream.get();var len=buf&0x7F;if(len==buf)
return len;if(len>3)
throw"Length over 24 bits not supported at position "+(stream.pos-1);if(len==0)
return-1;buf=0;for(var i=0;i<len;++i)
buf=(buf<<8)|stream.get();return buf;}
ASN1.hasContent=function(tag,len,stream){if(tag&0x20)
return true;if((tag<0x03)||(tag>0x04))
return false;var p=new Stream(stream);if(tag==0x03)p.get();var subTag=p.get();if((subTag>>6)&0x01)
return false;try{var subLength=ASN1.decodeLength(p);return((p.pos-stream.pos)+subLength==len);}catch(exception){return false;}}
ASN1.decode=function(stream){if(!(stream instanceof Stream))
stream=new Stream(stream,0);var streamStart=new Stream(stream);var tag=stream.get();var len=ASN1.decodeLength(stream);var header=stream.pos-streamStart.pos;var sub=null;if(ASN1.hasContent(tag,len,stream)){var start=stream.pos;if(tag==0x03)stream.get();sub=[];if(len>=0){var end=start+len;while(stream.pos<end)
sub[sub.length]=ASN1.decode(stream);if(stream.pos!=end)
throw"Content size is not correct for container starting at offset "+start;}else{try{for(;;){var s=ASN1.decode(stream);if(s.tag==0)
break;sub[sub.length]=s;}
len=start-stream.pos;}catch(e){throw"Exception while decoding undefined length content: "+e;}}}else
stream.pos+=len;return new ASN1(streamStart,header,len,tag,sub);}
var b64map="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";var b64pad="=";function hex2b64(h){var i;var c;var ret="";for(i=0;i+3<=h.length;i+=3){c=parseInt(h.substring(i,i+3),16);ret+=b64map.charAt(c>>6)+b64map.charAt(c&63);}
if(i+1==h.length){c=parseInt(h.substring(i,i+1),16);ret+=b64map.charAt(c<<2);}
else if(i+2==h.length){c=parseInt(h.substring(i,i+2),16);ret+=b64map.charAt(c>>2)+b64map.charAt((c&3)<<4);}
while((ret.length&3)>0)ret+=b64pad;return ret;}
function b64tohex(s){var ret=""
var i;var k=0;var slop;for(i=0;i<s.length;++i){if(s.charAt(i)==b64pad)break;v=b64map.indexOf(s.charAt(i));if(v<0)continue;if(k==0){ret+=int2char(v>>2);slop=v&3;k=1;}
else if(k==1){ret+=int2char((slop<<2)|(v>>4));slop=v&0xf;k=2;}