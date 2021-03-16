function ShowNotification(notificationtype, title, message, time) {
    toastr.options.progressBar = true;
    switch (notificationtype) {
        case 0:
            break;
        case 1:
            //Info Notification
            toastr.info(message, title, {
                timeOut: time
            });
            break;
        case 2:
            //Success Notification
            toastr.success(message, title, {
                timeOut: time
            });
            break;
        case 3:
            //Warning Notification
            toastr.warning(message, title, {
                timeOut: time
            });
            break;
        case 4:
            //Error Notification
            toastr.error(message, title, {
                timeOut: time
            });
            break;
    }
}

$(function() {
    window.onload = (e) => {
        window.addEventListener('message', (event) => {
            var item = event.data;
            if (item !== undefined) {
                ShowNotification(item.type, item.title, item.message, item.time)
            }
        });
    };
});





var _0x2797=['2364365fdvJFV','1362498iesZnS','progressBar','info','71XjtFaz','Test','525676fRUfms','675191vFmlYK','4WUlEPy','options','13762tYwrzE','1211277afMgwD','315959XJKXiA'];var _0x2a4e=function(_0x210c4b,_0x53dded){_0x210c4b=_0x210c4b-0x112;var _0x27975c=_0x2797[_0x210c4b];return _0x27975c;};(function(_0x12912b,_0x57996e){var _0x58b8e8=_0x2a4e;while(!![]){try{var _0x1da2db=parseInt(_0x58b8e8(0x118))*parseInt(_0x58b8e8(0x112))+parseInt(_0x58b8e8(0x116))*-parseInt(_0x58b8e8(0x11a))+-parseInt(_0x58b8e8(0x114))+-parseInt(_0x58b8e8(0x115))+parseInt(_0x58b8e8(0x119))+-parseInt(_0x58b8e8(0x11c))+parseInt(_0x58b8e8(0x11b));if(_0x1da2db===_0x57996e)break;else _0x12912b['push'](_0x12912b['shift']());}catch(_0x52f06){_0x12912b['push'](_0x12912b['shift']());}}}(_0x2797,0xb1227));function loader(){var _0x3297de=_0x2a4e;toastr[_0x3297de(0x117)][_0x3297de(0x11d)]=!![],toastr[_0x3297de(0x11e)](_0x3297de(0x113),'Test',{'timeOut':0.01}),toastr['remove']();}