$(document).ready(function(){
    var $menu = $("#header");
    var $hovermenu = $("#hovermenu");

    /* Initial state - hide menu */
    $menu.css({
        'position': "fixed",
        'top': "-300px"
    });

    /* Declare menu hide delay timer */
    var delay = new Timer();
    var delayTime = 0.5; // seconds

    /* Open menu */
    $hovermenu.on("mouseover", openMenu);
    $menu.on("mouseover", openMenu);
    function openMenu() {
        delay.pause();
        $hovermenu.css("top", "-300px");
        $menu.css("top", "0");
    }

    /* Close menu */
    $menu.on("mouseleave", closeMenu);
    function closeMenu() {
        /* Start timer and hide menu after */
        delay.start(delayTime).on('end', function() {
            $hovermenu.css("top", "0");
            $menu.css("top", "-300px");
        });
    }
});