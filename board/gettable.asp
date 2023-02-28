<%
tab = Request("tab")

if tab <> "" then
    Session("table") = tab
    Response.Redirect("list.asp")
else
    Response.Redirect("board.asp")
end if
%>