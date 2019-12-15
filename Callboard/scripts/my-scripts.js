
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
}