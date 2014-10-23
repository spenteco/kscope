
function handleControl(widget) {

    if (widget == 'github_widget') {
        window.open('https://github.com/spenteco/kscope');
    }

    if (widget == 'about_widget') {
        window.open('../../posts/kscope.html');
    }
    
    if (widget == 'twitter_widget') {
        window.open('https://twitter.com/share?url=http://montaukedp.com/apps/kscope','width=550, height=500, scrollbars=no');
    }
}

function enable_widget(id) {
    
    $('#' + id).html(
        '<a href="javascript:handleControl(\'' + id + '\');" class="control_a">' + 
        $('#enabled_' + id).html() +
        '</a>'
    );
} 

$(document).ready(
    function() {
        
        enable_widget('github_widget');
        enable_widget('about_widget');
        enable_widget('twitter_widget');
    }
);
