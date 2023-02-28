<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

updateSql = "UPDATE Board_Re SET readnum = readnum + 1"
updateSql = updateSql & " WHERE board_idx = " & request("idx")

db.execute(updateSql)

Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM Board_Re WHERE board_idx=" & request("idx")

rs.Open sql, db, 1, 1

board_idx = rs("board_idx")
ref = rs("ref")
re_level = rs("re_level")
re_step = rs("re_step")
board_content = replace(rs("board_content"), chr(13) & chr(10), "<br>")

%>

<!DOCTYPE html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=rs("title")%> ����</title>
    <link rel="stylesheet" href="./css/content.css">
</head>
<body>
    <script>
        function sendRe() {
            document.re.submit()
        }
    </script>
    <div style="margin: auto;">
        <h2><%=rs("title")%> ����</h2>
        <div>
            <div>
                <table class="content-table">
                    <tr>
                        <td class="td-100 td-left">
                            <p class="td-text">�۾���</p>
                        </td>
                        <td class="td-100 td-right">
                            <p><%=rs("name")%></p>
                        </td>
                        <td class="td-100 td-left">
                            <p class="td-text">��¥</p>
                        </td>
                        <td class="td-100 td-right">
                            <p><%=rs("writeday")%></p>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-100 td-left">
                            <p class="td-text">�̸���</p>
                        </td>
                        <td class="td-180 td-right">
                            <a href="mailto:<%=rs("email")%>"><%=rs("email")%></a>
                        </td>
                        <td class="td-100 td-left">
                            <p class="td-text">Ȩ������</p>
                        </td>
                        <td class="td-180 td-right">
                            <a href="<%=rs("homepage")%>">
                                <%=rs("name")%>���� Ȩ������
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-100 td-left">
                            <p class="td-text">��ȸ�� : </p>
                        </td>
                        <td>
                            <p><%=rs("readnum")%></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>���� : </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><%=rs("board_content")%></p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <a href="javascript:sendRe()">
            <p>
                &lt;�亯�ϱ�&gt;
            </p>
        </a>
        <a href="list.asp">
            <p>
                &lt;����Ʈ�� ���ư���&gt;
            </p>
        </a>
        <a href="edit.asp?idx=<%=rs("board_idx")%>">
            <p>
                &lt;����&gt;
            </p>
        </a>
        <a href="del.asp?idx=<%=rs("board_idx")%>">
            <p>
                &lt;����&gt;
            </p>
        </a>
        <% if session("id") = "admin" then%>
        <p>������� ��й�ȣ : <%=rs("pwd")%></p>
        <% end if %>
    </div>
    <form name="re" method="post" action="./write.asp">
        <input type="hidden" name="board_idx" value="<%=board_idx%>">
        <input type="hidden" name="ref" value="<%=ref%>">
        <input type="hidden" name="re_step" value="<%=re_step%>">
        <input type="hidden" name="re_level" value="<%=re_level%>">
    </form>
</body>
</html>