
<script type="text/javascript">/* <![CDATA[ */var qm_si,qm_li,qm_lo,qm_tt,qm_th,qm_ts,qm_la;var qp="parentNode";var qc="className";var qm_t=navigator.userAgent;var qm_o=qm_t.indexOf("Opera")+1;var qm_s=qm_t.indexOf("afari")+1;var qm_s2=qm_s&&window.XMLHttpRequest;var qm_n=qm_t.indexOf("Netscape")+1;var qm_v=parseFloat(navigator.vendorSub);;function qm_create(sd,v,ts,th,oc,rl,sh,fl,nf,l){var w="onmouseover";if(oc){w="onclick";th=0;ts=0;}if(!l){l=1;qm_th=th;sd=document.getElementById("qm"+sd);if(window.qm_pure)sd=qm_pure(sd);sd[w]=function(e){qm_kille(e)};document[w]=qm_bo;sd.style.zoom=1;if(sh)x2("qmsh",sd,1);if(!v)sd.ch=1;}else  if(sh)sd.ch=1;if(sh)sd.sh=1;if(fl)sd.fl=1;if(rl)sd.rl=1;sd.style.zIndex=l+""+1;var lsp;var sp=sd.childNodes;for(var i=0;i<sp.length;i++){var b=sp[i];if(b.tagName=="A"){lsp=b;b[w]=qm_oo;b.qmts=ts;if(l==1&&v){b.style.styleFloat="none";b.style.cssFloat="none";}}if(b.tagName=="DIV"){if(window.showHelp&&!window.XMLHttpRequest)sp[i].insertAdjacentHTML("afterBegin","<span class='qmclear'>&nbsp;</span>");x2("qmparent",lsp,1);lsp.cdiv=b;b.idiv=lsp;if(qm_n&&qm_v<8&&!b.style.width)b.style.width=b.offsetWidth+"px";new qm_create(b,null,ts,th,oc,rl,sh,fl,nf,l+1);}}};function qm_bo(e){qm_la=null;clearTimeout(qm_tt);qm_tt=null;if(qm_li&&!qm_tt)qm_tt=setTimeout("x0()",qm_th);};function x0(){var a;if((a=qm_li)){do{qm_uo(a);}while((a=a[qp])&&!qm_a(a))}qm_li=null;};function qm_a(a){if(a[qc].indexOf("qmmc")+1)return 1;};function qm_uo(a,go){if(!go&&a.qmtree)return;if(window.qmad&&qmad.bhide)eval(qmad.bhide);a.style.visibility="";x2("qmactive",a.idiv);};;function qa(a,b){return String.fromCharCode(a.charCodeAt(0)-(b-(parseInt(b/2)*2)));}function qm_oo(e,o,nt){if(!o)o=this;if(qm_la==o)return;if(window.qmad&&qmad.bhover&&!nt)eval(qmad.bhover);if(window.qmwait){qm_kille(e);return;}clearTimeout(qm_tt);qm_tt=null;if(!nt&&o.qmts){qm_si=o;qm_tt=setTimeout("qm_oo(new Object(),qm_si,1)",o.qmts);return;}var a=o;if(a[qp].isrun){qm_kille(e);return;}qm_la=o;var go=true;while((a=a[qp])&&!qm_a(a)){if(a==qm_li)go=false;}if(qm_li&&go){a=o;if((!a.cdiv)||(a.cdiv&&a.cdiv!=qm_li))qm_uo(qm_li);a=qm_li;while((a=a[qp])&&!qm_a(a)){if(a!=o[qp])qm_uo(a);else break;}}var b=o;var c=o.cdiv;if(b.cdiv){var aw=b.offsetWidth;var ah=b.offsetHeight;var ax=b.offsetLeft;var ay=b.offsetTop;if(c[qp].ch){aw=0;if(c.fl)ax=0;}else {if(c.rl){ax=ax-c.offsetWidth;aw=0;}ah=0;}if(qm_o){ax-=b[qp].clientLeft;ay-=b[qp].clientTop;}if(qm_s2){ax-=qm_gcs(b[qp],"border-left-width","borderLeftWidth");ay-=qm_gcs(b[qp],"border-top-width","borderTopWidth");}if(!c.ismove){c.style.left=(ax+aw)+"px";c.style.top=(ay+ah)+"px";}x2("qmactive",o,1);if(window.qmad&&qmad.bvis)eval(qmad.bvis);c.style.visibility="inherit";qm_li=c;}else  if(!qm_a(b[qp]))qm_li=b[qp];else qm_li=null;qm_kille(e);};function qm_gcs(obj,sname,jname){var v;if(document.defaultView&&document.defaultView.getComputedStyle)v=document.defaultView.getComputedStyle(obj,null).getPropertyValue(sname);else  if(obj.currentStyle)v=obj.currentStyle[jname];if(v&&!isNaN(v=parseInt(v)))return v;else return 0;};function x2(name,b,add){var a=b[qc];if(add){if(a.indexOf(name)==-1)b[qc]+=(a?' ':'')+name;}else {b[qc]=a.replace(" "+name,"");b[qc]=b[qc].replace(name,"");}};function qm_kille(e){if(!e)e=event;e.cancelBubble=true;if(e.stopPropagation&&!(qm_s&&e.type=="click"))e.stopPropagation();};function qm_pure(sd){if(sd.tagName=="UL"){var nd=document.createElement("DIV");nd.qmpure=1;var c;if(c=sd.style.cssText)nd.style.cssText=c;qm_convert(sd,nd);var csp=document.createElement("SPAN");csp.className="qmclear";csp.innerHTML="&nbsp;";nd.appendChild(csp);sd=sd[qp].replaceChild(nd,sd);sd=nd;}return sd;};function qm_convert(a,bm,l){if(!l){bm.className=a.className;bm.id=a.id;}var ch=a.childNodes;for(var i=0;i<ch.length;i++){if(ch[i].tagName=="LI"){var sh=ch[i].childNodes;for(var j=0;j<sh.length;j++){if(sh[j]&&(sh[j].tagName=="A"||sh[j].tagName=="SPAN"))bm.appendChild(ch[i].removeChild(sh[j]));if(sh[j]&&sh[j].tagName=="UL"){var na=document.createElement("DIV");var c;if(c=sh[j].style.cssText)na.style.cssText=c;if(c=sh[j].className)na.className=c;na=bm.appendChild(na);new qm_convert(sh[j],na,1)}}}}}/* ]]> */</script>


 <c:choose>
 
 <c:when test="${myLoggedUser.role=='0' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Administration</a>
<ul>
<li><a href="index.htm?mdl=accesscon&edit=all&sid">Access Control</a></li>
</ul>
</li>
<li><a class="qmparent" href="javascript:void(0)">Data Entry</a>
 <ul>
 <li><a href="index.htm?mdl=personinfo&edit=all&sid">Personal Infos</a></li>
<li><a href="index.htm?mdl=enrollment&edit=all&sid">Enrollment</a></li>

<li><a href="index.htm?mdl=score&edit=all&sid">Score&frasl;Results</a></li>
<li><a href="index.htm?mdl=attendance&edit=all&sid">Attendance</a></li>
<li><a href="index.htm?mdl=discipline&edit=all&sid">Discipline</a></li>
 </ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  
  <li><a href="index.htm?mdl=analysis&view&sid">Analysis</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=comm">Communication</a>
  <ul>
  <li><a href="index.htm?mdl=alert&edit=all&sid">Alerts</a></li>
  <li><a href="index.htm?mdl=classlist&view&sid">Class List</a></li>
  <li><a href="index.htm?mdl=msg&edit=all&sid">Messages</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>

<c:when test="${myLoggedUser.role=='1' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Administration</a>
<ul>
<li><a href="index.htm?mdl=accesscon&edit=all&sid">Access Control</a></li>
</ul>
</li>
<li><a class="qmparent" href="javascript:void(0)">Data Entry</a>
 <ul>
 <li><a href="index.htm?mdl=personinfo&edit=all&sid">Personal Infos</a></li>
<li><a href="index.htm?mdl=enrollment&edit=all&sid">Enrollment</a></li>

<li><a href="index.htm?mdl=score&edit=all&sid">Score&frasl;Results</a></li>
<li><a href="index.htm?mdl=attendance&edit=all&sid">Attendance</a></li>
<li><a href="index.htm?mdl=discipline&edit=all&sid">Discipline</a></li>
 </ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  
  <li><a href="index.htm?mdl=analysis&view&sid">Analysis</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=comm">Communication</a>
  <ul>
  <li><a href="index.htm?mdl=alert&edit=all&sid">Alerts</a></li>
  <li><a href="index.htm?mdl=msg&edit=all&sid">Messages</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>
 

 <c:when test="${myLoggedUser.role=='3' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Data Entry</a>
 <ul>
 <li><a href="index.htm?mdl=personinfo&edit=all&sid">Personal Infos</a></li>
 </ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  
  <li><a href="index.htm?mdl=analysis&view&sid">Analysis</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=comm">Communication</a>
  <ul>
  <li><a href="index.htm?mdl=msg&edit=all&sid">Messages</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>
 
 <c:when test="${myLoggedUser.role=='2' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Data Entry</a>
 <ul>

<li><a href="index.htm?mdl=enrollment&edit=all&sid">Enrollment</a></li>

 </ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  
  <li><a href="index.htm?mdl=analysis&view&sid">Analysis</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=comm">Communication</a>
  <ul>
  
  <li><a href="index.htm?mdl=msg&edit=all&sid">Messages</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>
 
 <c:when test="${myLoggedUser.role=='5' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Data Entry</a>
 <ul>

<li><a href="index.htm?mdl=score&edit=all&sid">Score&frasl;Results</a></li>
<li><a href="index.htm?mdl=attendance&edit=all&sid">Attendance</a></li>

 </ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  
  <li><a href="index.htm?mdl=analysis&view&sid">Analysis</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=comm">Communication</a>
  <ul>
  
  <li><a href="index.htm?mdl=msg&edit=all&sid">Messages</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>
 
 <c:when test="${myLoggedUser.role=='4' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Data Entry</a>
 <ul>
 <li><a href="index.htm?mdl=discipline&edit=all&sid">Discipline</a></li>
 </ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  
  <li><a href="index.htm?mdl=analysis&view&sid">Analysis</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=comm">Communication</a>
  <ul>
  <li><a href="index.htm?mdl=alert&edit=all&sid">Alerts</a></li>
  
  <li><a href="index.htm?mdl=msg&edit=all&sid">Messages</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>

<c:when test="${myLoggedUser.role=='7' }">
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="javascript:void(0)">Data Retrieval</a>
  <ul>
  <li><a href="index.htm?mdl=monitor&username=${myLoggedUser.userName }&view&sid">Monitoring</a></li>
  <li><a href="index.htm?mdl=profile&username=${myLoggedUser.userName }&view=all&sid">My Profile</a></li>
  </ul>
  </li>
  <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:when>
 <c:otherwise>
 <ul id="qm0" class="qmmc">
 <li><a class="qmparent" href="index.htm?mdl=logout">Logout</a></li>
 </ul>
 </c:otherwise>
 </c:choose>