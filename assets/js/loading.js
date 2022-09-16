import jquery from "./jquery-3.6.1.min.js"

window.jQuery = jquery;
window.$      = jquery;

function setTimes() {
    let now = Date.now() / 1000;
    // let bar = $('.timeout-bar').first().get()[0];
    for(let bar of $('.timeout-bar')) {
        let barId = bar.id;
        let characterId = barId.split('-')[1];

        let end = bar.getAttribute('utc_destination');
        let start = bar.getAttribute('utc_start');

        var length = end - start;
        let current = now - start;

        let textElement = $(`#remainder-${characterId}`)[0]

        percent = (1 - current / length);
        percent *= 100;

        if(current >= length) {
            bar.style.width = 0;
            textElement.textContent = 'Ready';
            let backbar = $(`#backbar-${characterId}`)[0]
            backbar.classList.remove('bg-white');
            backbar.classList.add('bg-emerald-500');
            backbar.classList.add('progress-bar-black');
            
            continue;
        }

        
        percent = Math.max(percent, 1)

        bar.style.width = `${percent}%`

        textElement.textContent = humanizeTime(end, now);
    }
}

function humanizeTime(end, now) {
    remainder = end - now;
    minutes = remainder / 60;
    hours = minutes / 60;
    minutes = minutes % 60;

    // console.log(remainder)
    console.log(minutes)

    minutes = Math.floor(minutes);
    hours = Math.floor(hours);

    data = []

    if(hours > 1) data.push(`${hours} hour${hours == 1 ? '' : 's'}`);
    if(minutes > 1) data.push(`${minutes} minute${minutes == 1 ? '' : 's'}`);

    return data.join(', ');
}

setTimes();

setInterval(setTimes, 1000);