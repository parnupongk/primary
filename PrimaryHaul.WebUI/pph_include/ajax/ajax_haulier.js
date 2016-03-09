function haulier_del(varType, varID) {
    var r = confirm("Press OK For Delete");
    if (r == true) {
        var req = Inint_AJAX();
        var str = Math.random();
        var str_url_address = "./pph_include/ajax/files/ajax_haulier.aspx";
        var str_url = "varType=" + varType;
        str_url += "&varID=" + varID;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    alert('Delete Success');
                    window.location.reload();
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

}