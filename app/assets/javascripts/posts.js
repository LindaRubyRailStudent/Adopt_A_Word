jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};


$("#new_post").before('<div id "flash_notice"><%= escape_javascript(flash.delete(:notice))%></div>');
$("#post_count").html("<%= pluralize(@post.count, 'Comment') %>");
$("#comments").append("<%= escape_javascript(render(:partial => @adoption.posts)) %>");


$("div.contentToChange p.new_post:hidden").slideDown("slow");
$("div.contentToChange p.new_post:visible").slideUp("slow");