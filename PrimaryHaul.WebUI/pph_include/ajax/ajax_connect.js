﻿function Inint_AJAX() {
    try { return new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { }
    try { return new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { }
    try { return new XMLHttpRequest(); } catch (e) { }
    alert("XMLHttpRequest not supported");
    return null;
}