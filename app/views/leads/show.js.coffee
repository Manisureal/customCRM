bootbox.dialog
  size: "medium"
  title: '<span style="color:#686868">Lead# <%=@lead.id%></span>'
  message: '<%= escape_javascript(render partial: "show") %>'
  buttons: {
    cancel: {
        label: "Close",
        className: 'btn-danger'
    }
  }