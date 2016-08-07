$(document).ready(function(){
    var $menu = $("#header");
    var $hovermenu = $("#hovermenu");

    $menu.css({
        'position': "fixed",
        'top': "-300px"
    });
    $hovermenu.text("Menu");

    $hovermenu.on("mouseenter", function() {
        $(this).css("top", "-300px");
        $menu.css("top", "0");
    });

    $menu.on("mouseleave", function() {
        $hovermenu.css("top", "0");
        $(this).css("top", "-300px");
    });
});