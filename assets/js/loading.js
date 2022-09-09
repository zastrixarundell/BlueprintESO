interval = setInterval(function() {
    percent = $('#timeout-bar').attr('percentage') - 1;
    if (percent < 0) {
        clearInterval(interval);
        $('#timeout-back').removeClass('bg-white');
        $('#timeout-back').addClass('bg-emerald-500');
        $('#timeout-back').addClass('progress-bar-black');
        return;
    };
    $('#timeout-bar').css('width', `${percent}%`)
    $('#timeout-bar').attr('percentage', percent)
}, 100);