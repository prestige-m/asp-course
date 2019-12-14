
$(".link-box").click(function() {
    window.location = $(this).find("a").attr("href");
    return false;
});

$(document).ready(function() {
    if ($(".container_list").length) {
        let regionID = $(".target").val();
        GetCities(regionID);
    } 
});

function GetCities(regionID) {
    //$.ajax({
    //    type: "POST",
    //    url: "WebForm1.aspx/GetCitiesInRegion",
    //    data: '{regionID: ' + regionID + '}',
    //    contentType: "application/json; charset=utf-8",
    //    dataType: "json",
        
    //    success: function(result) {
    //        OnSuccess(result);
    //        //alert(data.d); // trueconsole.log("Success");
    //    },
    //    error: function(xhr, status, error) {
    //        alert(xhr.responseText);  // to see the error message
    //    }
    //});
   PageMethods.GetCitiesInRegion(regionID, OnSuccess, OnError);
}

function OnSuccess(result) {
    let a = JSON.stringify(result, null, '\t');
    console.log(a);
    let dropdown = $('.container_list');
    dropdown.html('');

    $.each(result, function(k, v) {
        dropdown.append($("<option />").html(this.Name).val(this.ID));
    });
    //dropdown.prop('selectedIndex', 0);
}

function OnError(result) {
    alert(result);
}

$(".link-box").click(function() {
    window.location = $(this).find("a").attr("href");
    return false;
});

function SetChange(param) {
    $(".val").text(param);
    //console.log(param);
    //$(".container_list").val(param);
}